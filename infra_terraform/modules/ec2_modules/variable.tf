variable "projet_tags" {
    description = "tag projet"
    type = map(string)
    default = {
      "name" = "projet7"
    }
}
variable "type_instance" {
  type    = string
  default = "t2.nano"

}
variable "secur_group" {
    type = set(string)
    default = [ "." ]
  
}
variable "id_subnet" {
    description = "id_subnet"
    default = "."
    type = string
}
variable "expo" {
    type = bool
    description= "exposition instance"
    default = false
}