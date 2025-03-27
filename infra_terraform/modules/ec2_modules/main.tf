data "aws_ami" "this" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}
resource "aws_instance" "ec2" {
  ami             = data.aws_ami.this.id
  instance_type   = var.type_instance
  key_name        = "Giltab-us"
  tags            = var.projet_tags
  vpc_security_group_ids = var.secur_group
  subnet_id = var.id_subnet
  associate_public_ip_address = var.expo

  
  provisioner "local-exec" {
    command = "echo 'PRIVATE_IP : ${self.private_ip} ; AZ : ${self.availability_zone} ; PUBLIC_IP : ${self.public_ip}' >> ../out/info-ec2.txt"

  }


}