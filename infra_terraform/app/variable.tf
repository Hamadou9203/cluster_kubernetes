variable "region" {
  type    = string
  default = "us-east-1"

}

variable "private_key_path" {
  type = string
  default =  "/tmp/.ssh/"
  
}

variable "key_name" {
 type = string
  default = "Giltab-us.pem"
}