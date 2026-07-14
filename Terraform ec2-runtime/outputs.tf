output "public_ip" {

  value = aws_instance.runtime.public_ip
}

output "ssh" {

  value = "ssh -i terraform-key.pem ubuntu@${aws_instance.runtime.public_ip}"
}