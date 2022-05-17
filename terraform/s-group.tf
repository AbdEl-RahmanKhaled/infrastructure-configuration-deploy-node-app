resource "aws_security_group" "public-sg" {
  name        = "${var.ws_name}-public-sg"
  description = "public-sg"
  vpc_id      = module.network.vpc_id

  ingress {
    description      = "ssh from all"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.ws_name}-public-sg"
  }
}

resource "aws_security_group" "private-sg" {
  name        = "${var.ws_name}-private-sg"
  description = "public-sg"
  vpc_id      = module.network.vpc_id

  ingress {
    description      = "ssh from vpc"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [module.network.vpc_cidr_block]
  }

  ingress {
    description      = "custom from vpc"
    from_port        = 3000
    to_port          = 3000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.ws_name}-private-sg"
  }
}

# sg for mysql and redis
resource "aws_security_group" "db-sg" {
  name        = "${var.ws_name}-db-sg"
  description = "public-sg"
  vpc_id      = module.network.vpc_id

  ingress {
    description      = "all from vpc"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [module.network.vpc_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.ws_name}-db-sg"
  }
}

# resource "aws_db_security_group" "mysql-sg" {
#   name        = "${var.ws_name}-rds-sg"

#   ingress {
#     cidr             = module.network.vpc_cidr_block
#   }
# }