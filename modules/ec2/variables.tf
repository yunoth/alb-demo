variable "ami" {}
variable "instance_type" {}
variable "vpc_security_group_ids" {}
variable "subnet_id" {}
variable "associate_public_ip_address" { type = bool }
variable "user_data" {}
variable "tags" { type = map }
variable "key_name" {}
