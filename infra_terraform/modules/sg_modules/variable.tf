variable "sg_name" {
  type = string
  description = "sg name"
  default = "projet7-sg"
}
variable "id_vpc" {
  type = string
  description = "sg name"
  default = "."
}
variable "cdr_net" {
  type = list(string)
  description = "cdr block"
  default = [ "." ]
  
}