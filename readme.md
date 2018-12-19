
TODO: setup on kubeflow
TODO: data for other notebooks
TODO: add screenshots to readme


https://forums.fast.ai/t/fastai-v0-7-install-issues-thread/24652 

1. install Make and gcloud commandline tools for a bash shell
1. create Google cloud account and project
1. Go to https://console.cloud.google.com/iam-admin/quotas?
    1. find "Compute `Engine API: GPUs (all regions)"
    1. Check this quota and ask to edit edit quota
1. set up gcloud credentials from command line
1. get your kaggle.json file into this directory [Instructions](https://github.com/Kaggle/kaggle-api)
    1. make sure you agree to any kaggle competitions first
1. update makefile with your project, zone, and deployment name, then run
    1. `make deploy` 
1. key trying the following command until you successfully connect
    1. `make ssh` (you need to wait a bit while the make instance spins up)
1. Open your preferred browser for jupyter lab and go to 8080:localhost:8080
1. Open a new terminal window in this directory (so as a local user), then run
    1. `make scp`
1. Open a terminal window in jupyter lab (so as remote jupyter user), then run
    1. `make setup`
1. you now can run the lesson #1 notebook: fastai/courses/dl1/ via juptyer lab
1. you will need to change the kernel from the default to the fastai environment
    1. ABLE TO GET ENVIRONMENTS IN JUPYTER LAB AFTER THIS https://ipython.readthedocs.io/en/stable/install/kernel_install.html#kernels-for-different-environments