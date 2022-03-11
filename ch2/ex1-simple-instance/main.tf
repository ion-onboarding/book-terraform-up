terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.4.0"
    }
  }
}

variable "prefix_name" {
  description = "prefix of the tags, defaults to `ion` string "
  default     = "ion"
  type        = string
}

variable "region" {
  description = "provide region where to create the resources"
  default     = "eu-north-1"
  type        = string
}

provider "aws" {
  region = var.region
}

resource "random_pet" "suffix_name" {
  length = 1
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

resource "aws_instance" "web" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.subnet_web.id
  key_name                    = aws_key_pair.ssh-key.key_name
  associate_public_ip_address = "true"
  vpc_security_group_ids      = [aws_security_group.web-server.id]
  tags = {
    Name = "${var.prefix_name}-ubuntu"
  }
  user_data = <<-EOF
                #!/bin/bash
                echo "Hello, World" > index.html
                nohup busybox httpd -f -p 8080 &
                EOF
}