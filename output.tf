output "instance_public_ip" {
  description = "Public IP address if instance"
  value       = aws_instance.web_server.public_ip
}
