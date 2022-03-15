terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.5.0"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}

variable "prefix_name" {
  description = "prefix of the tags, defaults to `ion` string "
  default     = "ion"
  type        = string
}

resource "random_pet" "suffix_name" {
  length = 1
}

resource "tls_private_key" "keys" {
  algorithm = "RSA"
}

resource "aws_key_pair" "ssh-key" {
  key_name   = "${var.prefix_name}-ssh-key-${random_pet.suffix_name.id}"
  public_key = tls_private_key.keys.public_key_openssh

  tags = {
    Name = "${var.prefix_name}-key-pair-${random_pet.suffix_name.id}"
  }
}

resource "local_file" "ssh-key-file" {
  content         = tls_private_key.keys.private_key_pem
  filename        = "./artifacts/id_rsa.priv"
  file_permission = "0600"
}

module "vpc" {
  source     = "./modules/vpc/"
  random_pet = random_pet.suffix_name.id
}

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
  security_groups             = [module.vpc.sg]
  user_data                   = <<-EOF
              #!/bin/bash
              echo "<h1 style="text-align:center">Hello from hostname <span style="color:green">$HOSTNAME<span></h1>" > index.html
              echo "<h1 style="text-align:center">public IP:<span style="color:green">`curl http://169.254.169.254/latest/meta-data/public-ipv4`<span></h1>" >> index.html
              nohup busybox httpd -f -p 80 &
              EOF
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "ubuntu" {
  launch_configuration = aws_launch_configuration.ubuntu.name
  vpc_zone_identifier  = [module.vpc.private_subnet]
  desired_capacity     = 3
  min_size             = 3
  max_size             = 4
  tag {
    key                 = "Name"
    value               = format("%s_%s_", random_pet.suffix_name.id, "asg-ubuntu")
    propagate_at_launch = true
  }
}

data "aws_instances" "asg-instances" {
  instance_tags = {
    Name = format("%s_%s_", random_pet.suffix_name.id, "asg-ubuntu")
  }

  instance_state_names = ["running"]
  depends_on = [
    aws_autoscaling_group.ubuntu
  ]
}

output "access_SSH" {
  value = formatlist("ssh -i ./artifacts/id_rsa.priv -o 'StrictHostKeyChecking no' ubuntu@%s", data.aws_instances.asg-instances.public_ips)
}

output "access_WWW" {
  value = formatlist("http://%s", data.aws_instances.asg-instances.public_ips)
}