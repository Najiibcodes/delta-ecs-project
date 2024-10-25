output "dns_name" {
  value = aws_lb.front_end.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.front_end.arn
}

output "listener_arn" {
  value = aws_lb_listener.front_end.arn
}