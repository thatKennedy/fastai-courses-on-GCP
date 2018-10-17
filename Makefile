ZONE = us-west1-b
DEPLOYMENT_NAME = fast-ai
PROJECT = rl-engine


start:
	gcloud compute instances start --project ${PROJECT} --zone ${ZONE} ${DEPLOYMENT_NAME}-vm

list:
	gcloud compute instances list

update:
	gcloud compute scp --project ${PROJECT} --zone ${ZONE} setup.ipynb jupyter@${DEPLOYMENT_NAME}-vm:~/
	gcloud compute scp --project ${PROJECT} --zone ${ZONE} kaggle.json jupyter@${DEPLOYMENT_NAME}-vm:~/

lab:
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
	--command "nvidia-smi -l 5"

default:
	gcloud config set project --zone ${ZONE} ${PROJECT}


# still using ipynb for most of this

repo:
	gcloud compute ssh jupyter@${DEPLOYMENT_NAME}-vm --zone ${ZONE}\
	 --command "if [ ! -d fastai ] ; thengit clone https://github.com/fastai/fastai fi\
	 cd fastai
	 git pull
	 cd .."


env:
	gcloud compute ssh ${DEPLOYMENT_NAME}-vm --zone ${ZONE} \
	--command "conda env update -n base -f ../jupyter/fastai/environment.yml"