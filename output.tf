output "instance_public_ip" {
  description = "Public IP address if instance"
  value       = aws_instance.web_server.public_ip
}

output "website_url" {
  description = "website_url"
  value       = "https://${aws_route53_record.www.fqdn}"
}
