# AWS Region for deployment
variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "eu-west-2"  # Set your preferred AWS region
}

# Domain name for Route 53
variable "domain_name" {
  description = "Domain name for Route 53"
  type        = string
  default     = "teamdelta.com"  # Change to your actual domain name
}

# Security group name
variable "security_group_name" {
  description = "Name of the security group"
  type        = string
  default     = "app-security-group"  # Change as needed
}

# Ingress rule for application port
variable "app_port" {
  description = "Port on which the application listens"
  type        = number
  default     = 3000  # Port for your application
}

# CIDR block for inbound traffic
variable "ingress_cidr_block" {
  description = "CIDR block for inbound traffic"
  type        = string
  default     = "0.0.0.0/0"  # Change to restrict access in production
}

# CIDR block for outbound traffic
variable "egress_cidr_block" {
  description = "CIDR block for outbound traffic"
  type        = string
  default     = "0.0.0.0/0"  # Change as needed
}

# Description for the security group
variable "security_group_description" {
  description = "Description for the security group"
  type        = string
  default     = "Security group for the application"  # Change as needed
}
