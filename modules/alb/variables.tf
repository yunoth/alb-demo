variable "name" {}
variable "internal" { type = bool }
variable "security_groups" {}
variable "subnets" {}
variable "tags" { type = map }
variable "vpc_id" {}
variable "instance_id" { type = list }