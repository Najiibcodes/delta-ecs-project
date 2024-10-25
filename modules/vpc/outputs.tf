output "vpc_id" {
  value = aws_vpc.example.id
}


output "subnet_id" {
  value = aws_subnet.example.id
}

output "route_table_id" {
  value = aws_route_table.example.id
}