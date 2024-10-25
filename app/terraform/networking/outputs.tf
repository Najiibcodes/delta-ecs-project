output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_ids" {
  value = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
}

output "lb_security_group_id" {
  value = aws_security_group.lb_sg.id
}

output "lb_arn" {
  value = aws_lb.app_lb.arn
}
