terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.87.0"
    }
  }
  required_version = "1.10.5"
}
provider "aws" {
  alias                    = "east"
  region                   = local.region
  shared_credentials_files = ["../../.secrets/creds"]
  profile                  = "default"

}
module "natgw" {
    source = "../modules/natgw_modules"
    id_vpc = module.vpc.vpc_sortie_id
    id_subnet_pub = module.list_subnet.public_1_sortie_id
}
module "sg" {
  source = "../modules/sg_modules"
  id_vpc = module.vpc.vpc_sortie_id
  cdr_net = [ module.list_subnet.private_1_sortie_cdr, module.list_subnet.private_2_sortie_cdr, module.list_subnet.public_1_sortie_cdr, module.list_subnet.public_2_sortie_cdr ]
}
module "list_subnet" {
  source = "../modules/subnet_modules"
  net_vpc = local.net_vpc
  id_vpc = module.vpc.vpc_sortie_id
  region = local.region
}
module "ec2_bastion" {
  source = "../modules/ec2_modules"
  type_instance = local.type_instance
  projet_tags = {
    Name = "kub-bastion"
  }
  secur_group = [ module.sg.sortie_sg_bastion ]
  id_subnet = module.list_subnet.public_2_sortie_id
  expo = true
}
module "ec2_ansible" {
  source = "../modules/ec2_modules"
  type_instance = local.type_instance
  projet_tags = {
    Name = "kub-ansible"
  }
  secur_group = [ module.sg.sortie_sg_ansible ]
  id_subnet = module.list_subnet.private_1_sortie_id
  expo = false
}

module "ec2_master" {
  source = "../modules/ec2_modules"
  type_instance = "t2.large"
  projet_tags = {
    Name = "kub-master"
  }
  secur_group = [ module.sg.sortie_sg_kubenode ]
  id_subnet = module.list_subnet.private_1_sortie_id
  expo = false
}

module "ec2_woker1" {
  source = "../modules/ec2_modules"
  type_instance = local.type_instance
  projet_tags = {
    Name = "kub-worker"
  }
  secur_group = [ module.sg.sortie_sg_kubenode ]
  id_subnet = module.list_subnet.private_2_sortie_id
  expo = false
}
module "ec2_woker2" {
  source = "../modules/ec2_modules"
  type_instance = local.type_instance
  projet_tags = {
    Name = "kub-worker"
  }
  secur_group = [ module.sg.sortie_sg_kubenode ]
  id_subnet = module.list_subnet.private_2_sortie_id
  expo = false
}

module "vpc" {
    source = "../modules/vpc_modules"
    net_vpc = local.net_vpc
    projet_tags = local.projet_tags
}


resource "aws_route_table_association" "route_public_1" {
    subnet_id =module.list_subnet.public_1_sortie_id
    route_table_id = module.vpc.route_public_table_id
  
}
resource "aws_route_table_association" "route_public_2" {
    subnet_id =module.list_subnet.public_2_sortie_id
    route_table_id = module.vpc.route_public_table_id
  
}
resource "aws_route_table_association" "route_private_1" {
    subnet_id = module.list_subnet.private_1_sortie_id
    route_table_id = module.natgw.route_private_table_id
  
}
resource "aws_route_table_association" "route_private_2" {
    subnet_id = module.list_subnet.private_2_sortie_id
    route_table_id = module.natgw.route_private_table_id
  
}


resource "null_resource" "sortie" {
    provisioner "remote-exec" {
    inline = [ 
          "mkdir -p ${var.private_key_path}"
     ]
    
  }
    provisioner "file"  {
      source = "../../.secrets/${var.key_name}"
      destination = "${var.private_key_path}/${var.key_name}"
    }

    provisioner "remote-exec" {
      inline = [ 
        "chmod 0600 ${var.private_key_path}/${var.key_name}"
       ]
      
    }

    provisioner "remote-exec" {

    inline = [
      "ssh-keyscan -H ${module.ec2_ansible.sortie_ec2_priv} >> ~/.ssh/known_hosts",
      "ssh-keyscan -H ${module.ec2_woker1.sortie_ec2_priv} >> ~/.ssh/known_hosts",
      "ssh-keyscan -H ${module.ec2_worker2.sortie_ec2_priv} >> ~/.ssh/known_hosts",
      "ssh-keyscan -H ${module.ec2_master.sortie_ec2_priv} >> ~/.ssh/known_hosts",
      "ssh -A -i ${var.private_key_path}/${var.key_name} ubuntu@${module.ec2_ansible.sortie_ec2_priv} 'sudo apt update '",
      "ssh -A -i ${var.private_key_path}/${var.key_name} ubuntu@${module.ec2_ansible.sortie_ec2_priv} 'sudo apt install software-properties-common '",
      "ssh -A -i ${var.private_key_path}/${var.key_name} ubuntu@${module.ec2_ansible.sortie_ec2_priv} 'sudo add-apt-repository -y --update ppa:ansible/ansible'",
      "ssh -A -i ${var.private_key_path}/${var.key_name} ubuntu@${module.ec2_ansible.sortie_ec2_priv} 'sudo apt install ansible -y'"
    ]

  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("../../.secrets/${var.key_name}")
    host        = module.ec2_bastion.sortie_ec2_pub

  }
  
}