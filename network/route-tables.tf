resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.ws_name}-public-rt"
  }
}

# private routes
resource "aws_route_table" "private-rt-1" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-1.id
  }

  tags = {
    Name = "${var.ws_name}-private-rt-1"
  }
}

resource "aws_route_table" "private-rt-2" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-2.id
  }

  tags = {
    Name = "${var.ws_name}-private-rt-2"
  }
}