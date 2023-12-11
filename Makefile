EKS_CLUSTER_NAME=udacity-prj3-eks
HELM_REPO_NAME=udacity-pr3
HELM_POSTGRES_SVC_NAME=udacity

eks_config:
	sh ./.bin/eks_config.sh ${EKS_CLUSTER_NAME}
postgres_setup:
	sh ./.bin/psql_setup.sh ${HELM_REPO_NAME} ${HELM_POSTGRES_SVC_NAME}
seed_data:
	sh ./.bin/seed_data.sh
eks_deploy:
	sh ./.bin/eks_deploy.sh
expose:
	sh ./.bin/expose.sh
cloudwatch:
	sh ./.bin/cloud_watch_metrics_eks.sh
terraform_destroy:
	sh ./.bin/tf_destroy.sh

delete: terraform_destroy