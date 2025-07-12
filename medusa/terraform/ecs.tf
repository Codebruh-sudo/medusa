resource "aws_ecs_cluster" "medusa_cluster" {
  name = var.ecs_cluster_name
}

resource "aws_ecs_task_definition" "medusa_task" {
  family                   = "${var.project_name}-task"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "medusa"
      image     = "${aws_ecr_repository.medusa.repository_url}:latest"
      portMappings = [
        {
          containerPort = 9000
          hostPort      = 9000
          protocol      = "tcp"
        }
      ]
      environment = [
        {
          name  = "NODE_ENV"
          value = "production"
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "medusa_service" {
  name            = "${var.project_name}-service"
  cluster         = aws_ecs_cluster.medusa_cluster.id
  task_definition = aws_ecs_task_definition.medusa_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = [/* subnet IDs go here */]
    security_groups = [/* SG IDs go here */]
    assign_public_ip = true
  }

  depends_on = [aws_ecs_task_definition.medusa_task]
}
