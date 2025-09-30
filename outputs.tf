output "ec2_public_ip" {
  value = aws_instance.app.public_ip
}

output "ecr_repository_url" {
  value = aws_ecr_repository.app.repository_url
}

output "rds_endpoint" {
  value = aws_db_instance.postgres.address
}
