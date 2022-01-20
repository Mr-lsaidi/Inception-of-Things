kubectl delete deployment.apps/app-one service/app-one  -n kube-system
kubectl delete deployment.apps/app-two service/app-two  -n kube-system
kubectl delete deployment.apps/app-three service/app-three  -n kube-system
kubectl delete ingresses.networking.k8s.io/ingress  -n kube-system