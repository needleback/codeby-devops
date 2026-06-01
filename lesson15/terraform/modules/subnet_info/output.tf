output "vpc_name" {
  description = "Name of the analyzed VPC"
  value       = var.vpc_name
}

output "subnet_ids" {
  description = "Detailed information about subnets"
  value = {
    for id, subnet in data.aws_subnet.details : id => {
      name        = lookup(subnet.tags, "Name", "Unnamed")
      zone        = subnet.availability_zone
      cidr_block  = subnet.cidr_block
    }
  }
}
