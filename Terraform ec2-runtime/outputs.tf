#######################################
# EC2 Information
#######################################

output "public_ip" {
  description = "EC2 Public IP"
  value       = aws_instance.runtime.public_ip
}

output "ssh" {
  description = "SSH Command"
  value       = "ssh -i terraform-key.pem ubuntu@${aws_instance.runtime.public_ip}"
}

#######################################
# Runtime Platform URLs
#######################################

output "openwebui_url" {
  value = "http://${aws_instance.runtime.public_ip}:3000"
}

output "nginx_url" {
  value = "http://${aws_instance.runtime.public_ip}:8080"
}

output "apache_url" {
  value = "http://${aws_instance.runtime.public_ip}:8081"
}

output "tomcat_url" {
  value = "http://${aws_instance.runtime.public_ip}:8082"
}

output "wildfly_url" {
  value = "http://${aws_instance.runtime.public_ip}:8083"
}

output "remix_url" {
  value = "http://${aws_instance.runtime.public_ip}:8085"
}

output "webxr_url" {
  value = "http://${aws_instance.runtime.public_ip}:8090"
}

output "pocketbase_url" {
  value = "http://${aws_instance.runtime.public_ip}:8091"
}

output "jupyter_url" {
  value = "http://${aws_instance.runtime.public_ip}:8888"
}

output "portainer_url" {
  value = "http://${aws_instance.runtime.public_ip}:9000"
}

output "emqx_dashboard_url" {
  value = "http://${aws_instance.runtime.public_ip}:18083"
}

#######################################
# Database Endpoints
#######################################

output "mysql_endpoint" {
  value = "${aws_instance.runtime.public_ip}:3306"
}

output "mariadb_endpoint" {
  value = "${aws_instance.runtime.public_ip}:3307"
}

output "postgres_endpoint" {
  value = "${aws_instance.runtime.public_ip}:5432"
}

output "mongodb_endpoint" {
  value = "${aws_instance.runtime.public_ip}:27017"
}

output "redis_endpoint" {
  value = "${aws_instance.runtime.public_ip}:6379"
}

output "ganache_endpoint" {
  value = "http://${aws_instance.runtime.public_ip}:8545"
}