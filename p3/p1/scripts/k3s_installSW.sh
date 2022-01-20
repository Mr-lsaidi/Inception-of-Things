echo '<< start installSW >>'

echo "Token from SW is '$(cat /home/vagrant/node-token)'"
sudo yum install -y container-selinux selinux-policy-base
curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" INSTALL_K3S_EXEC="--node-ip 192.168.42.111" K3S_URL="https://192.168.42.110:6443" K3S_TOKEN="$(cat /home/vagrant/node-token)" sh -
echo '<< end installSW >>'
