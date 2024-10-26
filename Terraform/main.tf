#ECS Cluster
resource "aws_ecs_cluster" "threatcomposer-app" {
 name = "threatcomposer-app"


 setting {
   name  = "containerInsights"
   value = "enabled"
 }
}


#IAM Role
resource "aws_iam_role" "delta" {
 name = "delta"


 # Terraform's "jsonencode" function converts a
 # Terraform expression result to valid JSON syntax.
 assume_role_policy = jsonencode({
   Version = "2012-10-17"
   Statement = [
     {
       Action = "sts:AssumeRole"
       Effect = "Allow"
       Sid    = ""
       Principal = {
         Service = "ec2.amazonaws.com"
       }
     },
   ]
 })


 tags = {
   tag-key = "tag-value"
 }
}


# IAM Role Policy
resource "aws_iam_role_policy" "delta" {
 name = "delta"
 role = aws_iam_role.delta.id


 # Terraform's "jsonencode" function converts a
 # Terraform expression result to valid JSON syntax.
 policy = jsonencode({
   Version = "2012-10-17"
   Statement = [
     {
       Action = [
         "ec2:Describe*",
       ]
       Effect   = "Allow"
       Resource = "*"
     },
   ]
 })
}
#LB target group
resource "aws_lb_target_group" "lb-delta" {
 name     = "lb-delta"
 port     = 3000
 protocol = "HTTP"
 vpc_id   = aws_vpc.main.id
}


resource "aws_vpc" "main" {
 cidr_block = "10.0.0.0/16"
}


#ALB Load Balancer  Target Group
resource "aws_lb_target_group" "alb-delta" {
 name        = "alb-delta"
 target_type = "alb"
 port        = 80
 protocol    = "TCP"
 vpc_id      = aws_vpc.main.id
}




#Task Definiton ECS


resource "aws_ecs_task_definition" "service" {
  family = "service"
  container_definitions = jsonencode([

    {
      name      = "threatcomposer-app"
      image     = "585768150963.dkr.ecr.eu-west-2.amazonaws.com/threatcomposer-app:latest"
      cpu       = 10
      memory    = 256
      essential = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
    }
  ])

  volume {
    name      = "service-storage"
    host_path = "/ecs/service-storage"
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
  }
}


#Service for ECS


resource "aws_ecs_service" "threat-model" {
name            = "threat-model"
cluster         = aws_ecs_cluster.threatcomposer-app.id
task_definition = aws_ecs_task_definition.service.arn
desired_count   = 3
iam_role        = aws_iam_role.delta.arn
depends_on      = [aws_iam_role_policy.delta]




ordered_placement_strategy {
  type  = "binpack"
  field = "cpu"
}




load_balancer {
  target_group_arn = aws_lb_target_group.lb-delta.arn
  container_name   = "threat-model"
  container_port   = 3000
}




placement_constraints {
  type       = "memberOf"
  expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
}
}


#Subnet
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Main"
  }
}

#Route 53

resource "aws_route53_zone" "teamdelta" {
  name = "teamdelta.com"
}

#Route 53 CNAME Record

resource "aws_route53_record" "www-dev" {
  zone_id = aws_route53_zone.teamdelta.zone_id
  name    = "www.teamdelta.com"
  type    = "CNAME"
  ttl     = 5

  weighted_routing_policy {
    weight = 10
  }

  set_identifier = "dev"
  records        = ["dev.teamdelta.com"]
}

resource "aws_route53_record" "www-live" {
  zone_id = aws_route53_zone.teamdelta.zone_id
  name    = "www.teamdelta.com"
  type    = "CNAME"
  ttl     = 5

  weighted_routing_policy {
    weight = 90
  }

  set_identifier = "live"
  records        = ["live.teamdelta.com"]
}

# Certfiicate manager
resource "aws_acm_certificate" "cert" {
  domain_name       = "teamdelta.com"
  validation_method = "DNS"

  tags = {
    Environment = "test"
  }

  lifecycle {
    create_before_destroy = true
  }
}