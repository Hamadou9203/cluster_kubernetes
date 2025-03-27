provider "aws" {
  region = var.region
}

data "aws_availability_zones" "zone" {
  
}
resource "aws_subnet" "public_1" {
  availability_zone = data.aws_availability_zones.zone.names[0]
  vpc_id = var.id_vpc
  cidr_block = cidrsubnet(var.net_vpc,8,1)
}
resource "aws_subnet" "public_2" {
   availability_zone = data.aws_availability_zones.zone.names[1]
   vpc_id = var.id_vpc
   cidr_block = cidrsubnet(var.net_vpc,8,2)
}
resource "aws_subnet" "private_1" {
   availability_zone = data.aws_availability_zones.zone.names[0]
   vpc_id = var.id_vpc 
   cidr_block = cidrsubnet(var.net_vpc,8,101) 
}
resource "aws_subnet" "private_2" {
  availability_zone = data.aws_availability_zones.zone.names[1]
  vpc_id = var.id_vpc
  cidr_block = cidrsubnet(var.net_vpc,8,102)
}