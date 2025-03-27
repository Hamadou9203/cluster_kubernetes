output "sortie_sg_bastion" {
  value = aws_security_group.allow_bastion.id
}

output "sortie_sg_ansible" {
  value = aws_security_group.access-ansible.id
}

output "sortie_sg_kubenode" {
  value = aws_security_group.access-kube_node.id
}

