resource "aws_ecs_cluster" "main" {
  name = "threat-composer-cluster"
}

resource "aws_ecs_task_definition" "app" {
  family                   = "threat-composer-task"
  container_definitions    = <<DEFINITION
  [
    {
      "name": "app",
      "image": "${var.ecr_repo_url}",
      "cpu": 256,
      "memory": 512,
      "essential": true,
      "portMappings": [
        {
          "containerPort": 80,
          "hostPort": 80
        }
      ]
    }
  ]
  DEFINITION
}

resource "aws_ecs_service" "app_service" {
  name            = "app-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.subnet_ids
    security_groups = [var.security_group_id]
  }

  load_balancer {
    target_group_arn = var.load_balancer_arn
    container_name   = "app"
    container_port   = 80
  }
}

resource "aws_lb_target_group" "app_tg" {
  name     = "app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}
