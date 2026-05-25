module "create_vm_a" {
  source = "./modules/create_vm"

  vpc_name = aws_vpc.custom_vpc.tags.Name
  zone = var.subnen_zone_a
}
output "out_vm_tag_name_a" {
  value = module.create_vm_a.vm_tag_name
}
output "out_vm_id_a" {
  value = module.create_vm_a.vm_id
}



module "create_vm_b" {
  source = "./modules/create_vm"

  vpc_name = aws_vpc.custom_vpc.tags.Name
  zone = var.subnen_zone_b
}
output "out_vm_tag_name_b" {
  value = module.create_vm_b.vm_tag_name
}
output "out_vm_id_b" {
  value = module.create_vm_b.vm_id
}
