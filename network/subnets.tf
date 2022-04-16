# public subnets
resource "aws_subnet" "public-sub-zone-1" {
  vpc_id            = aws_vpc.my-vpc.id
  cidr_block        = var.pub_sub-1_cidr_block
  # "10.0.1.0/24"
  availability_zone = "${var.region}a"

  tags = {
    Name = "${var.ws_name}-public-sub-zone-1"
  }
}


resource "aws_subnet" "public-sub-zone-2" {
  vpc_id            = aws_vpc.my-vpc.id
  cidr_block        = var.pub_sub-2_cidr_block
  # "10.0.2.0/24"
  availability_zone = "${var.region}b"

  tags = {
    Name = "${var.ws_name}-public-sub-zone-2"
  }
}


# private subnets
resource "aws_subnet" "private-sub-zone-1" {
  vpc_id            = aws_vpc.my-vpc.id
  cidr_block        = var.priv_sub-1_cidr_block
  # "10.0.3.0/24"
  availability_zone = "${var.region}a"

  tags = {
    Name = "${var.ws_name}-private-sub-zone-1"
  }
}

resource "aws_subnet" "private-sub-zone-2" {
  vpc_id            = aws_vpc.my-vpc.id
  cidr_block        = var.priv_sub-2_cidr_block
  # "10.0.4.0/24"
  availability_zone = "${var.region}b"

  tags = {
    Name = "${var.ws_name}-private-sub-zone-2"
  }
}