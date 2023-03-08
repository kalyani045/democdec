resource "aws_vpc" "main" {
  cidr_block = var.vpc
  tags = {
    Name = "${var.allname}-vpc"
  }
}

resource "aws_subnet" "main" {
  count      = length(var.subnetid)
  vpc_id     = aws_vpc.main.id
  cidr_block = element(var.subnetid, count.index)

  tags = {
    Name = element(var.subnetid, count.index)
  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.allname}-rt"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.allname}-igw"
  }
}

resource "aws_route_table_association" "subnet" {
  count          = length(var.subnetid)
  subnet_id      = element(aws_subnet.main.*.id, count.index)
  route_table_id = aws_route_table.rt.id
}