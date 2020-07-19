variable "vpc_tags" { type = "map" }
variable "cidr_block" {}
variable "public_subnet_cidr" { type = "list" }
variable "private_subnet_cidr" { type = "list" }
variable "subnet_tags" { type = "map" }
variable "az" { type = "list" }