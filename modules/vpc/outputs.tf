output "vpc_id" {
  value = data.aws_vpc.vpc_healthcheck.id
}

output "public_subnet_ids" {
  value = data.aws_subnets.eks_subnets.ids
}

output "security_group_id" {
  value       = aws_security_group.eks_sg.id
}