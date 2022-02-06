echo '<< start installS >>'

sudo yum install -y container-selinux selinux-policy-base
curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" INSTALL_K3S_EXEC="--node-ip 192.168.42.110" sh -
rm -f /home/vagrant/node-token
sudo cp /var/lib/rancher/k3s/server/token /home/vagrant/node-token
sudo chmod 644 /home/vagrant/node-token
sudo chown vagrant /home/vagrant/node-token
echo "Token from S is '$(cat /home/vagrant/node-token)'"
echo '<< end installS >>'
