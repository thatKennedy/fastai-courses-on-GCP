ROOT = ~/Code/fast-ai-dl1
ZONE = us-west1-b
DEPLOYMENT_NAME = fast-ai
PROJECT = fast-aing
IMAGE_FAMILY = pytorch-latest-cu92
ENV=fastai
PYTHON_ENV = /opt/anaconda3/envs/fastai/bin/python

default:
	gcloud config set project ${PROJECT}

start: default
	gcloud compute instances start --zone ${ZONE} ${DEPLOYMENT_NAME}-vm

connect: default
	gcloud compute ssh --zone ${ZONE} ${DEPLOYMENT_NAME}-vm -- -L 8080:localhost:8080

lab: start connect
	xdg-open http://localhost:8080

stop: default
	gcloud compute instances stop --zone ${ZONE} ${DEPLOYMENT_NAME}-vm

scp: default
	gcloud compute scp --zone=${ZONE} kaggle.json jupyter@${DEPLOYMENT_NAME}-vm:~/
	gcloud compute scp --zone=${ZONE} Makefile jupyter@${DEPLOYMENT_NAME}-vm:~/

env:
	conda update conda -y
	cd ~/fastai; conda env create -f environment.yml
	conda install ipykernel -n ${ENV} -y
	${PYTHON_ENV} -m ipykernel install --user --name myenv --display-name "Python (${ENV})"

data: default
	gcloud compute scp --zone=${ZONE} get-data.sh jupyter@${DEPLOYMENT_NAME}-vm:~/
	gcloud compute ssh --zone=${ZONE} jupyter@${DEPLOYMENT_NAME}-vm --command "chmod +x get-data.sh"
	gcloud compute ssh --zone=${ZONE} jupyter@${DEPLOYMENT_NAME}-vm --command "./get-data.sh"

deploy: default
	gcloud compute instances create ${DEPLOYMENT_NAME}-vm \
	--zone=${ZONE} \
	--image-family=${IMAGE_FAMILY} \
	--image-project=deeplearning-platform-release \
	--maintenance-policy=TERMINATE \
	--accelerator="type=nvidia-tesla-k80,count=1" \
	--metadata="install-nvidia-driver=True"

clone:
	git clone https://github.com/fastai/fastai.git

shell:
	gcloud compute ssh --project ${PROJECT} --zone ${ZONE} ${DEPLOYMENT_NAME}-vm

jshell:
	gcloud compute ssh --project ${PROJECT} --zone ${ZONE} jupyter@${DEPLOYMENT_NAME}-vm

delete:
	gcloud compute instances delete --project ${PROJECT} --zone ${ZONE} ${DEPLOYMENT_NAME}-vm

ilist:
	gcloud compute instances list

gpumon:
	gcloud compute ssh --project ${PROJECT} --zone ${ZONE} ${DEPLOYMENT_NAME}-vm \
	--command "nvidia-smi -l 1"

mem:
	gcloud compute ssh --project ${PROJECT} --zone ${ZONE} ${DEPLOYMENT_NAME}-vm \
	--command "free -m"
