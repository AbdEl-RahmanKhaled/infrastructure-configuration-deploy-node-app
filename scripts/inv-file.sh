
cat <<EOF > ../ansible/inventory
#[private:vars]
#StrictHostKeyChecking=no
#ServerAliveInterval=5
#ansible_ssh_common_args="-o ProxyCommand=\"ssh -i $1 -t -W %h:%p -q ubuntu@$2\"" 

[private]
$3
EOF