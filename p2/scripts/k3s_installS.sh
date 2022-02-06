echo '<< start installS >>'

sudo yum install -y container-selinux selinux-policy-base
curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" INSTALL_K3S_EXEC="--node-ip 192.168.42.110" sh -

echo '<< end installS >>'
