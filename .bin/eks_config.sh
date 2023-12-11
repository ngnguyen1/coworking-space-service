#!/bin/bash
aws eks --region us-east-1 --profile ngnguyen-devops-3 update-kubeconfig --name $1