ZONE = us-west2-b
INSTANCE_NAME = my-fastai-instance
INSTANCE_TYPE = n1-highmem-8
PROJECT = fast-aing
IMAGE_FAMILY = pytorch-latest-gpu
ACCELERATOR = nvidia-tesla-k80

default:
	gcloud config set project ${PROJECT}

start: default
	gcloud compute instances start --zone ${ZONE} ${INSTANCE_NAME}

lab: default
	xdg-open http://localhost:8080
	gcloud compute ssh --zone ${ZONE} ${INSTANCE_NAME} -- -L 8080:localhost:8080


stop: default
	gcloud compute instances stop --zone ${ZONE} ${INSTANCE_NAME}

data: default
	gcloud compute scp --zone=${ZONE} get-data.sh jupyter@${DEPLOYMENT_NAME}-vm:~/
	gcloud compute ssh --zone=${ZONE} jupyter@${DEPLOYMENT_NAME}-vm --command "chmod +x get-data.sh"
	gcloud compute ssh --zone=${ZONE} jupyter@${DEPLOYMENT_NAME}-vm --command "./get-data.sh"

dogscats:
	cd ~/data ; wget http://files.fast.ai/data/dogscats.zip; unzip -q dogscats.zip

imdb:
	cd ~/data ; wget http://files.fast.ai/data/aclImdb.tgz; tar -xvzf aclImdb.tgz
	cd ~/data/aclImdb; mkdir models

deploy: default
	gcloud compute instances create ${INSTANCE_NAME} \
	--zone=$ZONE \
	--image-family=$IMAGE_FAMILY \
	--image-project=deeplearning-platform-release \
	--boot-disk-size=${BOOT_DISK_SIZE} \
	--maintenance-policy=TERMINATE \
	--accelerator="type=${ACCELERATOR},count=1" \
	--machine-type=${INSTANCE_TYPE} \
	--boot-disk-size=200GB \
	--metadata="install-nvidia-driver=True" \
	--preemptible

shell:
	gcloud compute ssh --project ${PROJECT} --zone ${ZONE} ${INSTANCE_NAME}

jshell:
	gcloud compute ssh --project ${PROJECT} --zone ${ZONE} jupyter@${INSTANCE_NAME}

delete:
	gcloud compute instances delete --project ${PROJECT} --zone ${ZONE} ${INSTANCE_NAME}

list:
	gcloud compute instances list

gpumon:
	gcloud compute ssh --project ${PROJECT} --zone ${ZONE} ${INSTANCE_NAME}
	--command "nvidia-smi -l 1"

memory:
	gcloud compute ssh --project ${PROJECT} --zone ${ZONE} ${INSTANCE_NAME}
	--command "free -m"
