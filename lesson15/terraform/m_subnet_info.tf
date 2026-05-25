module "subnet_info" {
  source = "./modules/subnet_info"
  vpc_name = aws_vpc.custom_vpc.tags.Name
}

output "out_vps_name" {
  value = module.subnet_info.vpc_name
}

output "out_subnet_ids" {
  value = module.subnet_info.subnet_ids
}
