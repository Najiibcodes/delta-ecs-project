#Repsitroy name
variable "repository_name" {
  description = "The name of the source code repository"
  type        = string
  default     = "delta-ecs-project"  
}

#Repository owner
variable "repository_owner" {
  description = "The owner of the repository"
  type        = string
  default     = "OsmanA12"  
}

#Buildspec
variable "buildspec" {
  description = "The buildspec file path"
  type        = string
  default     = "buildspec.yml"  # Path to your buildspec file
}


# AWS Region
variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "eu-west-2"  
}

# Domain for Route 53 and ACM
variable "domain_name" {
  description = "Root domain name for Route 53 and ACM"
  type        = string
  default     = "teamdelta.com"  # Replace with your domain
}

# ECS Cluster
variable "ecs_cluster_name" {
  description = "Name of the ECS Cluster"
  type        = string
  default     = "threatcomposer-app"
}

# IAM Role
variable "iam_role_name" {
  description = "Name of the IAM Role for ECS service"
  type        = string
  default     = "delta"
}

# VPC
variable "vpc_cidr" {
  description = "CIDR block for the main VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# Subnet
variable "subnet_cidr" {
  description = "CIDR block for the main subnet"
  type        = string
  default     = "10.0.1.0/24"
}

# ECS Task Definition
variable "ecs_family_name" {
  description = "Name of the ECS task family"
  type        = string
  default     = "service"
}

variable "ecs_container_name1" {
  description = "Name of the first container in the task definition"
  type        = string
  default     = "threatcomposer-td"
}

variable "ecs_container_name2" {
  description = "Name of the second container in the task definition"
  type        = string
  default     = "threatcomposer-app"
}


variable "ecs_container_port" {
  description = "Port for the container"
  type        = number
  default     = 3000
}

variable "ecs_container_memory1" {
  description = "Memory (in MiB) for the first container"
  type        = number
  default     = 512
}

variable "ecs_container_memory2" {
  description = "Memory (in MiB) for the second container"
  type        = number
  default     = 256
}

# Load Balancer
variable "load_balancer_port" {
  description = "Port for the Load Balancer"
  type        = number
  default     = 3000
}

variable "load_balancer_protocol" {
  description = "Protocol for the Load Balancer"
  type        = string
  default     = "HTTP"
}

# Route 53 Weighted Routing
variable "record_ttl" {
  description = "Time-to-live for Route 53 records"
  type        = number
  default     = 5
}

variable "dev_weight" {
  description = "Weight for dev environment in Route 53 weighted routing"
  type        = number
  default     = 10
}

variable "live_weight" {
  description = "Weight for live environment in Route 53 weighted routing"
  type        = number
  default     = 90
}
