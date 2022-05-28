resource "aws_security_group" "eks_sg" {
  name        = "EKS-sg"
  description = "EKS-sg"
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
    Name = "EKS-sg"
  }
}