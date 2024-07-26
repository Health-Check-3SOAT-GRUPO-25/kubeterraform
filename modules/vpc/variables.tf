variable "project_name" {
  description = "Nome do projeto, usado para taggear os recursos."
  default     = "healthcheck"
}

variable "cidr_block" {
  description = "CIDR block for the VPC."
  type        = string
}

