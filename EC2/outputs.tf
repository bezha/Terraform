output "turquoise_public_ip" {
  value       = aws_instance.turquoise.public_ip
  description = "The public IP address of the EC2"
}