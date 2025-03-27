resource "aws_eip" "my_eip" {
  domain = "vpc"
}
resource "aws_nat_gateway" "my_natgw" {
  subnet_id = var.id_subnet_pub
  allocation_id = aws_eip.my_eip.id
}
resource "aws_route_table" "private_rt" {
  vpc_id = var.id_vpc
  route{
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.my_natgw.id
  }
}