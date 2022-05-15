resource "null_resource" "out" {
  provisioner "local-exec" {
    command = "echo '[private:vars]' > ../ansible/inventory"
 
  }

  provisioner "local-exec" {
    command = "echo 'StrictHostKeyChecking=no' >> ../ansible/inventory"
 
  }

  provisioner "local-exec" {
    command = "echo 'ServerAliveInterval=5' >> ../ansible/inventory"
 
  }
  provisioner "local-exec" {
    command = "echo 'ansible_ssh_common_args=\"-o ProxyCommand=\\\"ssh -i ../key/key.pem -t -W %h:%p -q ubuntu@${aws_instance.pub-ec2.public_dns}\\\"\" \n\n[private]' >> ../ansible/inventory"
 
  }

 
  provisioner "local-exec" {
    command = "echo '${aws_instance.priv-ec2.private_ip}' >> ../ansible/inventory && echo '${tls_private_key.private_key_pair.private_key_pem}' > ../key/key.pem && chmod 600 ../key/key.pem"
 
  }

  provisioner "local-exec" {
    command = "echo '${tls_private_key.private_key_pair.private_key_pem}' > /home/jenkins/.ssh/key.pem && chmod 600 /home/jenkins/.ssh/key.pem"
 
  }
}