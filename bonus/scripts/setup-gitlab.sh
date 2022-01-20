ip=$(ip addr ls enp0s3 | grep 'inet ' | cut -d: -f2 | awk '{print $2}' | cut -d/ -f1)

curl -s https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo os=ubuntu dist=trusty  bash

sudo EXTERNAL_URL="http://$ip" apt-get install gitlab-ce

echo '===============done installing packages (gitlab-ce) =================='

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

echo '===============done installing Helm =================='

kubectl create -f rbac.yml

port=`kubectl cluster-info | grep -E 'Kubernetes master|Kubernetes control plane' | awk '/http/ {print $NF}' | cut -d: -f3`

echo "Cluster name: $(k3d cluster list --no-headers | cut -d' ' -f1)"
echo
echo
echo "API URL: https://$ip:$port"
echo
echo "Certificate:"
echo
kubectl get secret $(kubectl get secret --no-headers=true | cut -d' ' -f1) -o jsonpath="{['data']['ca\.crt']}" | base64 --decode
echo
echo
echo "Token:"
echo
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep gitlab | awk '{print $1}') | grep token: | tr -s ' ' | cut -d' ' -f2
