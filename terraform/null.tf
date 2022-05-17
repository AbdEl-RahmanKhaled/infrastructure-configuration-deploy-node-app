resource "null_resource" "out" {
  provisioner "local-exec" {
    command = <<EOF
      echo '${tls_private_key.private_key_pair.private_key_pem}' > $HOME/.ssh/key.pem && chmod 600  /root/.ssh/key.pem
    EOF
  }
  
  provisioner "local-exec" {
    command = <<EOF
      ../scripts/inv-file.sh /var/jenkins_home/.ssh/key.pem ${aws_instance.pub-ec2.public_dns} private_instance
      ../scripts/config-file.sh ${aws_instance.pub-ec2.public_dns} ${aws_instance.priv-ec2.private_ip}
    EOF
  }

}