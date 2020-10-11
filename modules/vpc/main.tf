resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"
  tags             = var.vpc_tags
}

resource "aws_subnet" "public_subnet" {
  count             = length(var.public_subnet_cidr)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidr[count.index]
  availability_zone = var.az[count.index%2]
  tags              = var.subnet_tags
}

resource "aws_subnet" "private_subnet" {
  count             = length(var.private_subnet_cidr)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr[count.index]
  availability_zone = var.az[count.index%2]
  tags              = var.subnet_tags
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags   = var.vpc_tags
}


resource "aws_route_table" "r" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = var.vpc_tags
}

resource "aws_main_route_table_association" "a" {
  vpc_id         = aws_vpc.main.id
  route_table_id = aws_route_table.r.id
}

resource "aws_eip" "nat" {
  vpc      = true
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet.0.id
  tags = var.vpc_tags
}

resource "aws_route_table" "r-private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
  }
  tags = var.vpc_tags
}

resource "aws_route_table_association" "a" {
  count = length(var.private_subnet_cidr)
  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = aws_route_table.r-private.id
}


#--------------------------------------------------#

output "vpc_id" {
  value = aws_vpc.main.id
}
output "public_subnet_ids" {
  value = aws_subnet.public_subnet.*.id
}
output "private_subnet_ids" {
  value = aws_subnet.private_subnet.*.id
}
