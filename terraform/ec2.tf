resource "aws_instance" "pub-ec2" {
  ami                         = var.ami_id
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.public_key_pair.id
  vpc_security_group_ids      = [aws_security_group.public-sg.id]
  subnet_id                   = module.network.pub_sub-1_id
  associate_public_ip_address = true

  root_block_device {
    volume_size           = 8
    delete_on_termination = true
  }

  provisioner "local-exec" {
    command = "echo The server IP address is ${self.public_ip}"
  }

  tags = {
    Name = "${var.ws_name}-pub-ec2"
  }
}

resource "aws_instance" "priv-ec2" {
  ami                         = var.ami_id
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.public_key_pair.id
  vpc_security_group_ids      = [aws_security_group.private-sg.id]
  subnet_id                   = module.network.pri_sub-1_id
  associate_public_ip_address = false

  root_block_device {
    volume_size           = 8
    delete_on_termination = true
  }

  tags = {
    Name = "${var.ws_name}-priv-ec2"
  }

  provisioner "local-exec" {
    command = "echo '${self.public_dns}' > ../ansible/inventory"
  }
}