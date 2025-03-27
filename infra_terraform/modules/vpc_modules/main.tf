resource "aws_vpc" "my_vpc" {
    cidr_block = var.net_vpc
    tags = var.projet_tags
    enable_dns_hostnames = true
    enable_dns_support = true

}

resource "aws_internet_gateway" "my_itgw" {
  
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route_table" "public" {

  vpc_id = aws_vpc.my_vpc.id
  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_itgw.id

  }

    
  
}
