variable "net_vpc" {
    description = "network vpc"
    type = string
    default = "10.0.0.0/16"
  
}
variable "projet_tags" {
    description = "tag projet"
    type = map(string)
    default = {
      "name" = "projet7"
    }
}