# variables.tf

variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "eu-west-2"
}

#ECS cluster
variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
  default     = "threatcomposer-cluster"
}

#ECR Image
variable "ecr_repository_name" {
  description = "Name of the ECR respository"
  type        = string
  default     = "threat-composer-ecr"
}

variable "container_name" {
  description = "Name of the container"
  type        = string
  default     = "threat-composer-container"
}

variable "container_port" {
  description = "Port on which the container listens"
  type        = number
  default     = 3000
}

variable "memory" {
  description = "Memory for the container in MiB"
  type        = number
  default     = 512
}

variable "cpu" {
  description = "CPU units for the container"
  type        = number
  default     = 256
}

variable "desired_count" {
  description = "Number of instances of the task to run"
  type        = number
  default     = 1
}

variable "vpc_id" {
  description = "VPC ID for load balancer"
  type        = string
  default     = ""
}
