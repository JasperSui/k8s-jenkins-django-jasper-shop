parent_path="$( cd "$(dirname "$0")" ; pwd -P )"
project_path=$parent_path/..
cd $project_path

kubectl apply -f jaspershop-api.yaml
kubectl apply -f jaspershop-db.yaml
kubectl apply -f rabbitmq.yaml
kubectl apply -f basic-ingress.yaml
kubectl apply -f jenkins-ingress.yaml