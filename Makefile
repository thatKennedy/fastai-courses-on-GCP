
# should add vars up here


connect:
	gcloud compute ssh --project rl-engine --zone us-west1-b fast-ai-vm -- -L 8080:localhost:8080



start:
	gcloud compute instances start --zone ${ZONE} ${DEPLOYMENT_NAME}-vm

lab:
	xdg-open http://localhost:8080
	gcloud compute ssh --project ${PROJECT} --zone ${ZONE} ${DEPLOYMENT_NAME}-vm -- -L 8080:localhost:8080

lab2:
	xdg-open http://localhost:8080
	gcloud compute ssh --project ${PROJECT} --zone ${ZONE} ${DEPLOYMENT_NAME}-vm -- -L 8888:localhost:8888


shell:
	gcloud compute ssh --zone ${ZONE} ${DEPLOYMENT_NAME}-vm

jshell:
	gcloud compute ssh jupyter@${DEPLOYMENT_NAME}-vm --zone ${ZONE}


stop:
	gcloud compute instances stop --project rl-engine --zone us-west1-b fast-ai-vm

delete:
	gcloud compute instances delete --zone ${ZONE} ${DEPLOYMENT_NAME}-vm


default:
	gcloud config set project --zone ${ZONE} ${PROJECT}
