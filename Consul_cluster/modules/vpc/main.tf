data "aws_availability_zones" "available_az" {
  state = "available"
}

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "private_subnets" {
  count             = var.rsc_count
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 3, count.index)
  availability_zone = data.aws_availability_zones.available_az.names[count.index]

  tags = {
    Name = "${var.vpc_name}-private-subnet-${count.index}"
  }

}

resource "aws_route_table" "private_route" {
  count  = var.rsc_count
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.vpc_name}-privateRT-${count.index}"
  }
}

resource "aws_route_table_association" "private_route_assoc" {
  count          = var.rsc_count
  subnet_id      = element(aws_subnet.private_subnets.*.id, count.index)
  route_table_id = element(aws_route_table.private_route.*.id, count.index)
}


resource "aws_subnet" "public_subnets" {
  count             = var.rsc_count
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, count.index + 8)
  availability_zone = data.aws_availability_zones.available_az.names[count.index]

  tags = {
    Name = "${var.vpc_name}-public-subnet-${count.index}"
  }

}

resource "aws_route_table_association" "public_route_assoc" {
  count          = var.rsc_count
  subnet_id      = element(aws_subnet.public_subnets.*.id, count.index)
  route_table_id = element(aws_route_table.public_route.*.id, count.index)
}

resource "aws_route_table" "public_route" {
  count  = var.rsc_count
  vpc_id = aws_vpc.vpc.id
  tags = {

    Name = "${var.vpc_name}-publicRT-${count.index}"
  }
}

module "aws_internet_gateway" {
  source = "../igw/"
  vpc_id = aws_vpc.vpc.id

}

resource "aws_route" "public_igw" {
  count                  = var.rsc_count
  route_table_id         = element(aws_route_table.public_route.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = module.aws_internet_gateway.igw_id
}

module "eip" {
  source    = "../eip"
  eip_count = var.rsc_count

}

resource "aws_nat_gateway" "ngw" {
  count         = var.rsc_count
  subnet_id     = element(aws_subnet.public_subnets.*.id, count.index)
  allocation_id = element(module.eip.eip_alloc_id, count.index)
  tags = {

    Name = "${var.vpc_name}-public-natgw-${count.index}"
  }
}

resource "aws_route" "private_nat_gateway" {
  count                  = var.rsc_count
  route_table_id         = element(aws_route_table.private_route.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.ngw.*.id, count.index)
}
