# Coworking Space Service Extension

The Coworking Space Service is a set of APIs that enables users to request one-time tokens and administrators to authorize access to a coworking space. This service follows a microservice pattern and the APIs are split into distinct services that can be deployed and managed independently of one another.

## Project Instructions

### Dependencies

- AWS Account
- AWS CLI
- Terraform
- Helm Chart
- PostgresSQL

### Project Structure

.bin: Bash files for running script like config cluster, setup database ...
db: Scripts to seed data
deployments: Kubernetes yml files
terraform: Terraform files to create AWS resource
screenshots: Screenshots

### How to run

- Create AWS resources using terraform:

```bash
cd terraform
tf plan -out solution.plan
tf apply solution.plan
```

- Config Kubect with EKS Cluster Name with `kubectl`

```bash
make eks_config
```

Set up PostgreSQL with Helm Chart and seed data

```bash
make postgres_setup
# Get password by command by running command:
kubectl get secret --namespace default udacity-postgresql -o jsonpath="{.data.postgres-password}" | base64 -d
# copy the output then copy to postgresql's password in deployments/env-secret.yml
# Seed data
make seed_data
```

Create a service and deployment yaml files to deploy web api

```bash
make eks_deploy
```

Create an external load balancer using kubectl expose

```bash
make expose
```

Check web api and logs from cloudwatch

![daily usage](screenshots/exposed%20api%20test.png)

![user visits](screenshots/exposed%20api%20test%202.png)

### CloudWatch Metrics in EKS

Kubernetes clusters created with EKS are set up to integrate with CloudWatch Container Insights by default.

Configuring CloudWatch Insights CloudWatch insights are easy to configure on your cluster.

- Node Role Policy Your policy for your EKS node role should include CloudWatchAgentServerPolicy for the agent to properly forward metrics.

- Install CloudWatch Agent In the following command, replace <YOUR_CLUSTER_NAME_HERE> on line 1 with the name of your EKS cluster and replace <YOUR_AWS_REGION_HERE> on line 2 with your AWS region. Then, run the command on an environment that has kubectl configured.

```bash
ClusterName=<YOUR_CLUSTER_NAME_HERE>
RegionName=<YOUR_AWS_REGION_HERE>
FluentBitHttpPort='2020'
FluentBitReadFromHead='Off'
[[ ${FluentBitReadFromHead} = 'On' ]] && FluentBitReadFromTail='Off'|| FluentBitReadFromTail='On'
[[ -z ${FluentBitHttpPort} ]] && FluentBitHttpServer='Off' || FluentBitHttpServer='On'
curl https://raw.githubusercontent.com/aws-samples/amazon-cloudwatch-container-insights/latest/k8s-deployment-manifest-templates/deployment-mode/daemonset/container-insights-monitoring/quickstart/cwagent-fluent-bit-quickstart.yaml | sed 's/{{cluster_name}}/'${ClusterName}'/;s/{{region_name}}/'${RegionName}'/;s/{{http_server_toggle}}/"'${FluentBitHttpServer}'"/;s/{{http_server_port}}/"'${FluentBitHttpPort}'"/;s/{{read_from_head}}/"'${FluentBitReadFromHead}'"/;s/{{read_from_tail}}/"'${FluentBitReadFromTail}'"/' | kubectl apply -f -
```

This will install CloudWatch insights into the namespace amazon-cloudwatch on your cluster.

### Deliverables

All deliverables are stored in `./screenshots` folder.
