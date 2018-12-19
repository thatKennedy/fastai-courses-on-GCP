PROJECT = fast-aing
ZONE = us-west1-b
MACHINE_TYPE = n1-standard-8
ACCELERATOR = type=nvidia-tesla-k80,count=1
DEPLOYMENT_NAME = fast-ai
IMAGE_FAMILY = pytorch-latest-cu92
ENV=fastai
PYTHON_ENV = /opt/anaconda3/envs/fastai/bin/python

default:
	gcloud config set project ${PROJECT}

start: default
	gcloud compute instances start --zone ${ZONE} ${DEPLOYMENT_NAME}-vm

ssh: default
	gcloud compute ssh --zone ${ZONE} ${DEPLOYMENT_NAME}-vm -- -L 8080:localhost:8080

lab: start ssh

stop: default
	gcloud compute instances stop --zone ${ZONE} ${DEPLOYMENT_NAME}-vm

setup: clone env data

scp: default
	gcloud compute scp --zone=${ZONE} kaggle.json jupyter@${DEPLOYMENT_NAME}-vm:~/
	gcloud compute scp --zone=${ZONE} Makefile jupyter@${DEPLOYMENT_NAME}-vm:~/

clone:
	git clone https://github.com/fastai/fastai.git

env:
	conda update conda -y
	cd ~/fastai; conda env create -f environment.yml
	conda install ipykernel -n ${ENV} -y
	${PYTHON_ENV} -m ipykernel install --user --name myenv --display-name "Python (${ENV})"

data: default
	mkdir data
	cd ~/data ; wget http://files.fast.ai/data/dogscats.zip; unzip -q dogscats.zip
	cd ~/fastai/courses/dl1/; ln -s ~/data ./

deploy: default
	gcloud compute instances create ${DEPLOYMENT_NAME}-vm \
	--zone=${ZONE} \
	--machine-type=${MACHINE_TYPE} \
	--image-family=${IMAGE_FAMILY} \
	--image-project=deeplearning-platform-release \
	--maintenance-policy=TERMINATE \
	--accelerator="${ACCELERATOR}" \
	--metadata="install-nvidia-driver=True"


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
