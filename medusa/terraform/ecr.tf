resource "aws_ecr_repository" "medusa" {
  name                 = var.ecr_repo_name
  image_tag_mutability = "MUTABLE"
}

