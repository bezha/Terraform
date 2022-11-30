output "turquoise_public_ip" {
  value       = aws_instance.cv_turquoise.public_ip
  description = "The public IP address of the cv_turquoise container"
}

output "green_public_ip" {
  value       = aws_instance.cv_green.public_ip
  description = "The public IP address of the cv_green container"
}

output "burgundy_public_ip" {
  value       = aws_instance.cv_burgundy.public_ip
  description = "The public IP address of the cv_burgundy container"
}

output "alb_dns_name" {
  value       = aws_lb.CV.dns_name
  description = "The domain name of the load balancer"
}
