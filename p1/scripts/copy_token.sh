echo '==== Copying token ===='
rm -f node-token
scp -o "StrictHostKeyChecking=no" vagrant@192.168.42.110:/home/vagrant/node-token node-token
scp -o "StrictHostKeyChecking=no" node-token vagrant@192.168.42.111:/home/vagrant/node-token