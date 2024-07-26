variable "project_name" {
  description = "Nome do projeto, usado para taggear os recursos."
  default     = "healthcheck"
}

variable "cluster_version" {
  description = "Versão do Kubernetes para o cluster EKS."
  type        = string
  default     = "1.29"
}

variable "cluster_name" {
  description = "Nome do cluster EKS."
  default     = "healthcheck-cluster-eks"
}

variable "node_group_desired_capacity" {
  description = "Número desejado de instâncias no node group do EKS."
  type        = number
  default     = 3
}

variable "node_group_max_capacity" {
  description = "Número máximo de instâncias no node group do EKS."
  type        = number
  default     = 4
}

variable "node_group_min_capacity" {
  description = "Número mínimo de instâncias no node group do EKS."
  type        = number
  default     = 2
}

variable "node_group_instance_type" {
  description = "Tipo de instância EC2 para os nodes do EKS."
  type        = string
  default     = "t3.medium"
}

variable "LabRoleName" {
  description = "Name for the LabRole IAM role"
  default     = "LabRole"
}

variable "PrincipalRoleName" {
  description = "Name for the Principal IAM role"
  default     = "voclabs"
}

variable "policyarn" {
  default = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
}

variable "acessConfig" {
  default = "API_AND_CONFIG_MAP"
}


variable "aws_region" {
  description = "Região da AWS para provisionar os recursos."
  default     = "us-east-1"
}


variable "subnet_ids" {
  description = "A list of subnet IDs to launch resources in."
  type        = list(string)
}

variable "security_group_id" {
  description = "The ID of the security group to associate with the EKS cluster."
  type        = string
}

