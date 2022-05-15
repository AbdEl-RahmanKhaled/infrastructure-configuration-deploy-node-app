resource "null_resource" "out" {
  provisioner "local-exec" {
    command = "echo '${aws_instance.pub-ec2.public_dns}' > ../ansible/inventory & echo '${tls_private_key.private_key_pair.private_key_pem}' > ../key/key.pem && chmod 600 ../key/key.pem"
  }
}