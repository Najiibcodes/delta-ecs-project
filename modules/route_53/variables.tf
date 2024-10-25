# variables.tf

variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "eu-west-2"  # Set your preferred AWS region
}

variable "domain_name" {
  description = "Domain name for Route 53"
  type        = string
  default     = "teamdelta.com"  # Change to your actual domain name
}
