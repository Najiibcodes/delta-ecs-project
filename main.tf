provider "aws" {
  region = var.aws_region
}
#ECS Cluster
resource "aws_ecs_cluster" "foo" {
  name = "threatcomposer-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

#ECS Task Definition
resource "aws_ecs_task_definition" "service" {
  family = "threatcomposer"
  container_definitions = jsonencode([
    {
      name      = "first"
      image     = ""
      cpu       = 10
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
    },
  ])

  volume {
    name      = "service-storage"
    host_path = "/ecs/service-storage"
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [eu-west-2a, eu-west-2b]"
  }
}
