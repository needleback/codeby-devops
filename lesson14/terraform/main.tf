# Создание ВМ в Public подсети
resource "aws_instance" "public_vm" {
  ami                         = "ami-df5de72bdb3b"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.public_sg.id]
  associate_public_ip_address = true
  user_data                   = var.user_data
  tags                        = { Name = "public-vm" }
}

# Создание ВМ в Private подсети
resource "aws_instance" "private_vm" {
  ami                         = "ami-df5de72bdb3b"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.private_subnet.id
  vpc_security_group_ids      = [aws_security_group.private_sg.id]
  associate_public_ip_address = false
  user_data                   = var.user_data
  tags                        = { Name = "private-vm" }
}
