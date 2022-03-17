variable "region" {
  description = "AWS region"
  default = "eu-north-1"
  type = string
}

provider "aws" {
  region = var.region
}

resource "random_pet" "suffix_name" {
  length = 1
}

resource "tls_private_key" "keys" {
  algorithm = "RSA"
}

resource "aws_key_pair" "ssh-key" {
  key_name   = "ssh-key-${random_pet.suffix_name.id}"
  public_key = tls_private_key.keys.public_key_openssh

  tags = {
    Name = "key-pair-${random_pet.suffix_name.id}"
  }
}

resource "local_file" "ssh-key-file" {
  content         = tls_private_key.keys.private_key_pem
  filename        = "./artifacts/id_rsa.priv"
  file_permission = "0600"
}

# Network

resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "vpc-${random_pet.suffix_name.id}"
  }
}

resource "aws_subnet" "subnet_pub_a" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = "eu-north-1a"
  cidr_block        = "10.0.1.0/24"
  tags = {
    Name = "subnet-${random_pet.suffix_name.id}"
  }
}

resource "aws_subnet" "subnet_pub_b" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = "eu-north-1b"
  cidr_block        = "10.0.2.0/24"
  tags = {
    Name = "subnet-${random_pet.suffix_name.id}"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "route-table-${random_pet.suffix_name.id}"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet_pub_a.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.subnet_pub_b.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_security_group" "sg-ubuntu" {
  name        = "server-ubuntu"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "Enter SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description     = "Enter WEB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.sg-load-balancer.id]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    security_groups = [aws_security_group.sg-load-balancer.id]
  }

  tags = {
    Name = "sg-server-${random_pet.suffix_name.id}"
  }
}

resource "aws_security_group" "sg-load-balancer" {
  name        = "load-loadbalancer"
  description = "allow HTTP"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "Enter WEB"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-load-balancer-${random_pet.suffix_name.id}"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "gw-${random_pet.suffix_name.id}"
  }
}

# Auto Scaling Group (ASG)

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_launch_configuration" "ubuntu" {
  name_prefix                 = format("%s_%s_", random_pet.suffix_name.id, "launch")
  key_name                    = aws_key_pair.ssh-key.key_name
  associate_public_ip_address = true
  image_id                    = data.aws_ami.ubuntu.id
  instance_type               = "t3.micro"
  security_groups             = [aws_security_group.sg-ubuntu.id]
  user_data                   = <<-EOF
              #!/bin/bash
              echo "<h1 style="text-align:center">Hello from hostname <span style="color:green">$HOSTNAME<span></h1>" > index.html
              nohup busybox httpd -f -p 80 &
              EOF
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "ubuntu" {
  launch_configuration = aws_launch_configuration.ubuntu.name
  vpc_zone_identifier  = [aws_subnet.subnet_pub_a.id]
  min_size             = 2
  desired_capacity     = 2
  max_size             = 3
  tag {
    key                 = "Name"
    value               = format("%s_%s_", random_pet.suffix_name.id, "asg-ubuntu")
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Application Load Balancer (NLB)

resource "aws_lb" "load-balancer" {
  name               = "load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg-load-balancer.id]
  subnets            = [aws_subnet.subnet_pub_a.id, aws_subnet.subnet_pub_b.id]

  tags = {
    Name = "key-pair-${random_pet.suffix_name.id}"
  }
}

resource "aws_lb_listener" "listen-HTTP" {
  load_balancer_arn = aws_lb.load-balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-group-asg-ubuntu.arn
  }
}

resource "aws_lb_target_group" "target-group-asg-ubuntu" {
  name     = "target-asg-ubuntu"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
}

resource "aws_autoscaling_attachment" "asg-ubuntu" {
  autoscaling_group_name = aws_autoscaling_group.ubuntu.id
  lb_target_group_arn    = aws_lb_target_group.target-group-asg-ubuntu.arn
}

# pull ASG instances, used for outputing the IPs

data "aws_instances" "asg-instances" {
  instance_tags = {
    Name = format("%s_%s_", random_pet.suffix_name.id, "asg-ubuntu")
  }

  instance_state_names = ["running"]
  depends_on = [
    aws_autoscaling_group.ubuntu
  ]
}

# output

output "access_LB_HTTP" {
  value = "http://${aws_lb.load-balancer.dns_name}"
}

output "access_SSH" {
  value = formatlist("ssh -i ./artifacts/id_rsa.priv -o 'StrictHostKeyChecking no' ubuntu@%s", data.aws_instances.asg-instances.public_ips)
}