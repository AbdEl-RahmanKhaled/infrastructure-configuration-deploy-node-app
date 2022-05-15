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
    command = "echo 'ansible_ssh_common_args=\"-o ProxyCommand=\\\"ssh -i /var/jenkins_home/.ssh/key.pem -t -W %h:%p -q ubuntu@${aws_instance.pub-ec2.public_dns}\\\"\" \n\n[private]' >> ../ansible/inventory"
 
  }

 
  provisioner "local-exec" {
    command = "echo '${aws_instance.priv-ec2.private_ip}' >> ../ansible/inventory"
 
  }

  provisioner "local-exec" {
    command = "echo '${tls_private_key.private_key_pair.private_key_pem}' > /var/jenkins_home/.ssh/key.pem && chmod 600  /var/jenkins_home/.ssh/key.pem"
 
  }
}