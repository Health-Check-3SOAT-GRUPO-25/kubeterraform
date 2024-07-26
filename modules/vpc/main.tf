resource "aws_security_group" "eks_sg" {
  name        = "eks-cluster-sg"
  description = "Security group for all nodes in the EKS cluster"
  vpc_id      = data.aws_vpc.vpc_healthcheck.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-cluster-sg"
  }
}

resource "aws_security_group_rule" "allow_eks_to_rds" {
  type                     = "ingress"
  from_port                = 1433  
  to_port                  = 1433
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_sg.id
  source_security_group_id = data.aws_security_group.healthcheck_sg_rds.id
}

resource "aws_security_group_rule" "allow_rds_to_eks" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = data.aws_security_group.healthcheck_sg_rds.id
  source_security_group_id = aws_security_group.eks_sg.id
}