module "ecr" {
  source = "./modules/ecr"
}

module "vpc_eks" {
  source     = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
}

module "eks" {
  source            = "./modules/eks"
  subnet_ids        = module.vpc_eks.public_subnet_ids
  security_group_id = module.vpc_eks.security_group_id
}
