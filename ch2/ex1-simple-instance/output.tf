output "WWW" {
  value = "http://${aws_instance.web.public_ip}"
}

output "connect_SSH" {
  value = "ssh -i ./artifacts/id_rsa.priv -o 'StrictHostKeyChecking no' ubuntu@${aws_instance.web.public_ip}"
}