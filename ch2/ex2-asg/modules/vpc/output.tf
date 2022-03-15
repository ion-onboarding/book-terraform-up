output "sg" {
  value = aws_security_group.sg-ubuntu.id
}

output "private_subnet" {
  value = aws_subnet.subnet_private.id
}