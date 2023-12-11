#!/bin/bash

BACKEND_DEPLOYMENT_NAME="backend-server"

# Kubectl expose
kubectl expose deployment $BACKEND_DEPLOYMENT_NAME --type=LoadBalancer --name=publicbackend