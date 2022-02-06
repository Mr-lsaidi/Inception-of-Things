#------------helm + runnder--------------

if [ "$#" -ne 1 ]; then
    echo "Usage: setup-runner.sh runner_token"
    exit
fi

kubectl create ns gitlab

helm repo add gitlab https://charts.gitlab.io

export GITLAB_URL="http://$(ip addr ls enp0s3 | grep 'inet ' | cut -d: -f2 | awk '{print $2}' | cut -d/ -f1)/"
export RUNNER_TOKEN=$1

envsubst < runner-conf.yml | helm install --namespace gitlab gitlab-runner -f - gitlab/gitlab-runner
