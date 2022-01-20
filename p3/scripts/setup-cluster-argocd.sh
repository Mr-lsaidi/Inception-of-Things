
curl -fsSL https://get.docker.com | bash
sudo usermod -aG docker $USER
sudo chmod 666 /var/run/docker.sock

curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o $USER -g $USER -m 0755 kubectl /usr/local/bin/kubectl

sudo curl -fsSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo chmod +x /usr/local/bin/argocd

echo alias k="kubectl" > ~/.bashrc ; source ~/.bashrc

echo '===============done installing packages=================='


k3d cluster create mycluster -p "8888:80@loadbalancer"

kubectl create ns argocd
kubectl apply -n argocd -f install.yml

echo Waiting for argocd web-interface endpoint...

params="-n argocd -l app.kubernetes.io/name=argocd-server --timeout=10m"
kubectl wait --for=condition=available deployment $params
kubectl wait --for=condition=ready pod $params

#apply ingress for the argocdUI in namespace argocd
kubectl create -f ingressArgo.yml