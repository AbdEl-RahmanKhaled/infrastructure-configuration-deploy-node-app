
cat <<EOF > $HOME/.ssh/config
host bastion
   HostName $1
   User ubuntu
   identityFile ~/.ssh/key.pem

host private_instance
   HostName  $2
   user  ubuntu
   ProxyCommand ssh bastion -W %h:%p
   identityFile ~/.ssh/key.pem
EOF