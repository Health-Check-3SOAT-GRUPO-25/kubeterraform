resource "aws_ecr_repository" "auth_ecr_repository" {
  name         = "${var.project_name}-auth-ecr"
  force_delete = true
  tags = {
    "Name"        = "${var.project_name}-auth-ecr"
    "Environment" = "development"
  }
}

resource "aws_ecr_repository" "appointment_ecr_repository" {
  name         = "${var.project_name}-appointment-ecr"
  force_delete = true
  tags = {
    "Name"        = "${var.project_name}-appointment-ecr"
    "Environment" = "development"
  }
}

