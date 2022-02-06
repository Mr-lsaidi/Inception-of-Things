if [ "$#" -ne 2 ]; then
    echo "Usage: setup-app.sh token repo_url"
    exit
fi

kubectl delete ns dev --ignore-not-found=true
kubectl create ns dev

export TOKEN="$1"
export REPO_URL="$2"

envsubst < appconf.yml | kubectl apply -f -
envsubst < secretconf.yml | kubectl apply -f -

#apply ingress for the app in namespace dev
kubectl apply -f ingressApp.yml

ip=$(ip addr ls enp0s3 | grep 'inet ' | cut -d: -f2 | awk '{print $2}' | cut -d/ -f1)
port="8888"

echo "ArgoCD link: http://$ip:$port/argocd"
echo "Application link: http://$ip:$port"
echo "\033[0;31mArgocd username: admin"
echo "\033[0;31mArgocd password: $(kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath={.data.password} | base64 --decode)\033[0m"