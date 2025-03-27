output "private_1_sortie_id" {
    value = aws_subnet.private_1.id
  
}
output "private_2_sortie_id" {
    value = aws_subnet.private_2.id
  
}
output "public_1_sortie_id" {
    value = aws_subnet.public_1.id
  
}
output "public_2_sortie_id" {
    value = aws_subnet.public_2.id
  
}
output "public_2_sortie_cdr" {
    value = aws_subnet.public_2.cidr_block
  
}
output "public_1_sortie_cdr" {
    value = aws_subnet.public_1.cidr_block
  
}
output "private_2_sortie_cdr" {
    value = aws_subnet.private_2.cidr_block
  
}
output "private_1_sortie_cdr" {
    value = aws_subnet.private_1.cidr_block
  
}