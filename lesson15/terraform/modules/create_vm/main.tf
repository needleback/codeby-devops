data "aws_vpc" "selected" {
  tags = { Name = var.vpc_name }
}

data "aws_subnets" "target" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
  filter {
    name   = "availability-zone"
    values = [var.zone]
  }
}

resource "aws_instance" "create_vm" {
  ami                         = "ami-df5de72bdb3b"
  instance_type               = "t2.micro"
  subnet_id                   = data.aws_subnets.target.ids[0]
  tags                        = { Name = "create_vm_${var.zone}" }
}

