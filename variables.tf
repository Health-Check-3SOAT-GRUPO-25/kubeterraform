variable "aws_region" {
  description = "Região da AWS para provisionar os recursos."
  default     = "us-east-1"
}

variable "tags" {
  description = "Mapa de tags aplicadas a todos os recursos criados."
  type        = map(string)
  default = {
    App      = "healthcheck",
    Ambiente = "Desenvolvimento"
  }
}


