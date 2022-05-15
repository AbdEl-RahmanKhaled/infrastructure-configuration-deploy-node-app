resource "tls_private_key" "private_key_pair" {
    algorithm = "RSA"
    rsa_bits  = 4096

  provisioner "local-exec" {
    
    command = "echo '${self.private_key_pem}' > ../key/key.pem && chmod 600 ../key/key.pem"
  }
}

resource "aws_key_pair" "public_key_pair" {
  key_name   = "${var.ws_name}-terraform-pub-key"
  public_key = tls_private_key.private_key_pair.public_key_openssh
}

resource "aws_secretsmanager_secret" "private_key" {
  name = "${var.ws_name}-terraform-priv-key"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret" "public_key" {
  name = "${var.ws_name}-terraform-pub-key"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "secret_key_value" {
  secret_id = aws_secretsmanager_secret.private_key.id
  secret_string = tls_private_key.private_key_pair.private_key_pem
}

resource "aws_secretsmanager_secret_version" "public_key_value" {
  secret_id = aws_secretsmanager_secret.public_key.id
  secret_string = aws_key_pair.public_key_pair.public_key
}