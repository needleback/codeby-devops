# Скрипт провижинера для установки Nginx
variable "user_data" {
  default = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y nginx
              systemctl start nginx
              systemctl enable nginx
              EOF
}

variable "subnen_zone_a" {
  default = "us-east-1a"
}

variable "subnen_zone_b" {
  default = "us-east-1b"
}
