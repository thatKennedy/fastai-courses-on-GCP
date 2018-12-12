ROOT = ~/Code/fast-ai-dl1
ZONE = us-west1-b
DEPLOYMENT_NAME = fast-ai
PROJECT = fast-aing
IMAGE_FAMILY = pytorch-latest-cu92

deploy:
	gcloud compute instances create ${DEPLOYMENT_NAME}-vm \
	--zone=${ZONE} \
	--image-family=${IMAGE_FAMILY} \
	--image-project=deeplearning-platform-release \
	--maintenance-policy=TERMINATE \
	--accelerator="type=nvidia-tesla-k80,count=1" \
	--metadata="install-nvidia-driver=True"

lab:
	gcloud compute instances start --project ${PROJECT} --zone ${ZONE} ${DEPLOYMENT_NAME}-vm

list:
	gcloud compute instances list

update:
	gcloud compute scp --project ${PROJECT} --zone ${ZONE} setup.ipynb jupyter@${DEPLOYMENT_NAME}-vm:~/
	gcloud compute scp --project ${PROJECT} --zone ${ZONE} kaggle.json jupyter@${DEPLOYMENT_NAME}-vm:~/.kaggle/

connect:
	xdg-open http://localhost:8080
	gcloud compute ssh --project ${PROJECT} --zone ${ZONE} ${DEPLOYMENT_NAME}-vm -- -L 8080:localhost:8080

shell:
	gcloud compute ssh --project ${PROJECT} --zone ${ZONE} ${DEPLOYMENT_NAME}-vm

jshell:
	gcloud compute ssh --project ${PROJECT} --zone ${ZONE} jupyter@${DEPLOYMENT_NAME}-vm

stop:
	gcloud compute instances stop --project ${PROJECT} --zone ${ZONE} ${DEPLOYMENT_NAME}-vm

delete:
	gcloud compute instances delete --project ${PROJECT} --zone ${ZONE} ${DEPLOYMENT_NAME}-vm

gpumon:
	gcloud compute ssh --project ${PROJECT} --zone ${ZONE} ${DEPLOYMENT_NAME}-vm \
	--command "nvidia-smi -l 1"

mem:
	gcloud compute ssh --project ${PROJECT} --zone ${ZONE} ${DEPLOYMENT_NAME}-vm \
	--command "free -m"

default:
	gcloud config set project --zone ${ZONE} ${PROJECT}


# still using the setup.ipynb for most of this stuff belowg

repo:
	gcloud compute ssh jupyter@${DEPLOYMENT_NAME}-vm --zone ${ZONE}\
	 --command "if [ ! -d fastai ] ; thengit clone https://github.com/fastai/fastai fi\
	 cd fastai
	 git pull
	 cd .."


env:
	gcloud compute ssh ${DEPLOYMENT_NAME}-vm --zone ${ZONE} \
	--command "conda env update -n base -f ../jupyter/fastai/environment.yml"