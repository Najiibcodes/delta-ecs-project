output "cluster_name" {
  value = aws_ecs_cluster.main.name
}

output "service_arn" {
  value = aws_ecs_service.main.arn
}

output "task_definition_arn" {
  value = aws_ecs_task_definition.main.arn
}
