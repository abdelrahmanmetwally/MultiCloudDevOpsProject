output "vpc-id" {
    value = aws_vpc.vpc.id
  
}
output "pub-route-table-id" {
  value = aws_route_table.main-route-table.id
}

