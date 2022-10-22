data "aws_availability_zones" "available" {
  state = "available"

  # Only fetch Availability Zones (no Local Zones)
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

resource "aws_vpc" "test_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = "test-vpc"
  }
}

resource "aws_network_acl" "main" {
  vpc_id = aws_vpc.test_vpc.id

  egress {
    protocol   = "all"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = "all"
    rule_no    = 101
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "all"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "all"
    rule_no    = 101
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "public_subnet" {
  count                   = var.public_subnet_count
  vpc_id                  = aws_vpc.test_vpc.id
  map_public_ip_on_launch = true

  cidr_block           = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone_id = data.aws_availability_zones.available.zone_ids[count.index % length(data.aws_availability_zones.available.zone_ids)]

  tags = tomap({ "Name" = "public_subnet-${data.aws_availability_zones.available.names[count.index]}" })
}

resource "aws_subnet" "private_subnet" {
  count                   = var.private_subnet_count
  vpc_id                  = aws_vpc.test_vpc.id
  map_public_ip_on_launch = true

  cidr_block           = cidrsubnet(var.vpc_cidr, 8, count.index + 4)
  availability_zone_id = data.aws_availability_zones.available.zone_ids[count.index % length(data.aws_availability_zones.available.zone_ids)]

  tags = tomap({ "Name" = "private_subnet-${data.aws_availability_zones.available.names[count.index]}" })
}


#Internet gateway
resource "aws_internet_gateway" "testvpc_igw" {
  vpc_id = aws_vpc.test_vpc.id

  tags = {
    Name = "test-vpc-igw"
  }
}

#Route table public
resource "aws_route_table" "testvpc_public_rt" {
  vpc_id = aws_vpc.test_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.testvpc_igw.id
  }

  tags = {
    Name = "Public subnet RT"
  }
}

#Assign RT to public subnet
resource "aws_route_table_association" "public-rt" {
  count          = var.public_subnet_count
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.testvpc_public_rt.id
}

#Route table private
resource "aws_route_table" "testvpc_private_rt" {
  vpc_id = aws_vpc.test_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
  }

  tags = {
    Name = "Public subnet RT"
  }
}

#Assign RT to private subnet
resource "aws_route_table_association" "private-rt" {
  count          = var.public_subnet_count
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.testvpc_private_rt.id
}

#NAT gateway
resource "aws_nat_gateway" "test-nat" {
  subnet_id = aws_subnet.public_subnet[0].id

  tags = {
    Name = "gw NAT"
  }
}