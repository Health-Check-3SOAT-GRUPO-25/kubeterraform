data "aws_availability_zones" "available" {
  # Assuming the region is 'us-east-1'
  filter {
    name   = "zone-name"
    values = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1f"]
  }
}

data "aws_caller_identity" "current" {}


data "aws_vpc" "vpc_healthcheck" {
  tags = {
    Name = "healthcheck-VPC"
  }
}

# data "aws_route_tables" "healthcheck_route_table" {
#   vpc_id = data.aws_vpc.vpc_healthcheck.id
#   tags = {
#     Purpose = "RoutingForRDS"
#   }
# }

data "aws_subnets" "eks_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc_healthcheck.id]
  }

  tags = {
    "Name" = "healthcheck-Private-Subnet-*"
  }
}

data "aws_subnet" "eks_subnet_details" {
  count = length(data.aws_subnets.eks_subnets.ids)
  id    = data.aws_subnets.eks_subnets.ids[count.index]
}


data "aws_security_groups" "healthcheck_sgs_rds" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc_healthcheck.id]
  }

  tags = {
    "Name" = "healthcheck-sql-server-rds-sg"
  }
}


data "aws_security_group" "healthcheck_sg_rds" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc_healthcheck.id]
  }

  tags = {
    "Name" = "healthcheck-sql-server-rds-sg"
  }
}