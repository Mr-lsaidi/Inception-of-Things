echo ' >> create ingress:'
/usr/local/bin/kubectl create -f /home/vagrant/apps/ingress.yml -n kube-system
echo ' >> create app-one:'
/usr/local/bin/kubectl create -f /home/vagrant/apps/app1/deploy.yml -n kube-system
/usr/local/bin/kubectl create -f /home/vagrant/apps/app1/srv.yml -n kube-system
echo ' >> create app-two:'
/usr/local/bin/kubectl create -f /home/vagrant/apps/app2/deploy.yml -n kube-system
/usr/local/bin/kubectl create -f /home/vagrant/apps/app2/srv.yml -n kube-system
echo ' >> create app-three:'
/usr/local/bin/kubectl create -f /home/vagrant/apps/app3/deploy.yml -n kube-system
/usr/local/bin/kubectl create -f /home/vagrant/apps/app3/srv.yml -n kube-system

# waiting for pods to be ready
while [[ $(/usr/local/bin/kubectl  get pod -l app=app-one -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}' -n kube-system) != "True" ]] \
    || [[ $(/usr/local/bin/kubectl  get pod -l app=app-two -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}' -n kube-system) != "True True True" ]] \
    || [[ $(/usr/local/bin/kubectl  get pod -l app=app-three -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}' -n kube-system) != "True" ]]; do echo "waiting for pods" && sleep 7; done