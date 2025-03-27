output "vpc_sortie_id" {
    value = aws_vpc.my_vpc.id
  
}

output "route_public_table_id" {
    value = aws_route_table.public.id
  
}
output "public_itgw" {
    value = aws_internet_gateway.my_itgw.id
  
}