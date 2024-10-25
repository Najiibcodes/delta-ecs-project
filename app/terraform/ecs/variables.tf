variable "vpc_id" {}
variable "subnet_ids" {
  type = list(string)
}
variable "ecr_repo_url" {
  description = "URL of the ECR repository for the container image"
}
variable "security_group_id" {
  description = "Security Group ID for ECS tasks"
}

variable "load_balancer_arn" {
  description = "ARN of the Load Balancer"
}
