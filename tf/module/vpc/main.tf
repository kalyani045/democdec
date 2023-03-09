resource "aws_vpc" "main" {
  cidr_block = var.vpccidr
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

resource "aws_subnet" "private" {
    count = length(var.privatesubnet)
    vpc_id = aws_vpc.main.id
    cidr_block = element(var.privatesubnet, count.index) 
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

resource "aws_route_table" "rtprivate" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.example.id
  }
  tags = {
    Name = "${var.allname}-rt-private"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.allname}-igw"
  }
}
resource "aws_eip" "eip" {
  vpc      = true
}

resource "aws_nat_gateway" "example" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.main[1].id 
  tags = {
    Name = "${var.allname}-nat"
  }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table_association" "subnet" {
  count          = length(var.subnetid)
  subnet_id      = element(aws_subnet.main.*.id, count.index)
  route_table_id = aws_route_table.rt.id
}
resource "aws_route_table_association" "private" {
  count          = length(var.privatesubnet)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.rtprivate.id
}