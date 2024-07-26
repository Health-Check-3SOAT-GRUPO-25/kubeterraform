output "ecr_auth_repository_url" {
  value = aws_ecr_repository.auth_ecr_repository.repository_url
}

output "ecr_appointment_repository_url" {
  value = aws_ecr_repository.appointment_ecr_repository.repository_url
}