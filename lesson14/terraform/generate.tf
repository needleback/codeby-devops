# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform
resource "aws_instance" "imported_vm" {
  ami                                  = "ami-df5de72bdb3b"
  associate_public_ip_address          = true
  availability_zone                    = "us-east-1a"
  disable_api_stop                     = false
  disable_api_termination              = false
  ebs_optimized                        = false
  get_password_data                    = false
  hibernation                          = null
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t2.micro"
  monitoring                           = false
  placement_partition_number           = 0
  private_ip                           = "10.238.122.200"
  secondary_private_ips                = []
  security_groups                      = []
  source_dest_check                    = true
  subnet_id                            = "subnet-3ea929ae"
  tags = {
    Name = "manual-vm"
  }
  tags_all = {
    Name = "manual-vm"
  }
  tenancy                     = "default"
  user_data_replace_on_change = null
  volume_tags                 = null
  vpc_security_group_ids      = []
  root_block_device {
    delete_on_termination = true
    encrypted             = false
    iops                  = 0
    tags                  = {}
    tags_all              = {}
    throughput            = 0
    volume_size           = 8
    volume_type           = "gp2"
  }
}
