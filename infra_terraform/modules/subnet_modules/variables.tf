
variable "id_vpc" {
  description = "id of vpc"
  type = string
  default = "."
}
variable "net_vpc" {
    description = "network vpc"
    type = string
    default = "10.0.0.0/16"
  
}
variable "region" {
  default = "us-east-1"
  description = "region aws"
  type = string
}