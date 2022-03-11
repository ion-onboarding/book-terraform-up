
resource "aws_security_group" "web-server" {
  name        = "web-server"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "Enter SSH"
    from_port   = 22
    to_port     = 22
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
    Name = "${var.prefix_name}-web-server-${random_pet.suffix_name.id}"
  }
}

resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.prefix_name}-vpc-${random_pet.suffix_name.id}"
  }
}

resource "aws_subnet" "subnet_web" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "${var.prefix_name}-subnet-${random_pet.suffix_name.id}"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "${var.prefix_name}-route-table-${random_pet.suffix_name.id}"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet_web.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.prefix_name}-gw-${random_pet.suffix_name.id}"
  }
}