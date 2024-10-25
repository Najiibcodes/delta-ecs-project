provider "aws" {
  region = "us-east-1"
}

module "networking" {
  source = "./networking"
}

module "ecr" {
  source = "./ecr"
}

module "ecs" {
  source           = "./ecs"
  vpc_id           = module.networking.vpc_id
  subnet_ids       = module.networking.subnet_ids
  ecr_repo_url     = module.ecr.repository_url
  security_group_id = module.networking.lb_security_group_id
  load_balancer_arn = module.networking.lb_arn
}
