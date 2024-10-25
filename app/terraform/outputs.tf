output "load_balancer_dns" {
  value = module.ecs.load_balancer_dns
}

output "ecr_repo_url" {
  value = module.ecr.repository_url
}
