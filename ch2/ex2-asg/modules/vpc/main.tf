variable "random_pet" {
}

variable "region" {
  description = "provide region where to create the resources"
  default     = "eu-north-1"
  type        = string
}

provider "aws" {
  region = var.region
}

resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "vpc-${var.random_pet}"
  }
}

resource "aws_subnet" "subnet_private" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "subnet-${var.random_pet}"
  }
}

resource "aws_security_group" "sg-ubuntu" {
  name        = "sgserver-ubuntu"
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
    Name = "sg-server-${var.random_pet}"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "route-table-${var.random_pet}"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet_private.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "gw-${var.random_pet}"
  }
}
