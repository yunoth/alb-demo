resource "aws_instance" "web" {
  ami                         = var.ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = var.vpc_security_group_ids
  subnet_id                   = var.subnet_id
  associate_public_ip_address = var.associate_public_ip_address
  user_data                   = var.user_data
  tags                        = var.tags
  key_name                    = var.key_name
}




#---------------------------------------------------------------#
output "id" {
  value = aws_instance.web.id
}