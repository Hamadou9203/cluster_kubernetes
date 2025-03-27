output "sortie_ec2_id" {
    value = aws_instance.ec2.id
  
}
output "sortie_ec2_pub" {
    value = aws_instance.ec2.public_ip
  
}
output "sortie_ec2_priv" {
    value = aws_instance.ec2.private_ip
  
}