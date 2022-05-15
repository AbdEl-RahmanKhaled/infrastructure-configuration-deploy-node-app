resource "aws_eip" "eip-1" {
  vpc = true

  tags = {
    Name = "${var.ws_name}-eip-1"
  }
}

resource "aws_eip" "eip-2" {
  vpc = true

  tags = {
    Name = "${var.ws_name}-eip-2"
  }
}