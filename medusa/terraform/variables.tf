variable "project_name" {
  description = "Name of the Medusa ECS project"
  default     = "medusa-app"
}

variable "aws_region" {
  description = "AWS region"
  default     = "ap-south-1"
}

variable "ecr_repo_name" {
  description = "ECR repository name"
  default     = "medusa-ecr"
}

variable "ecs_cluster_name" {
  description = "ECS Cluster name"
  default     = "medusa-cluster"
}
