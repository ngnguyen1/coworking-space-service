## Apply env variables and secrets
kubectl apply -f ./deployments/env-secret.yml
kubectl apply -f ./deployments/env-configmap.yml

## Deployments
kubectl apply -f ./deployments/coworking-deployment.yml

## Service
kubectl apply -f ./deployments/coworking-service.yml