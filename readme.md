

https://forums.fast.ai/t/fastai-v0-7-install-issues-thread/24652 

1. install Make and gcloud commandline tools
1. create Google cloud account and project
1. Go to https://console.cloud.google.com/iam-admin/quotas?
    1. find "Compute Engine API: GPUs (all regions)"
    1. Check this quota and ask to edit edit quota
1. set up gcloud credentials from command line: [Auth](https://cloud.google.com/sdk/gcloud/reference/auth/login)
1. get your kaggle.json file into this directory [Instructions](https://github.com/Kaggle/kaggle-api)
    1. make sure you agree to any kaggle competitions first
1. update makefile with your project, zone, and deployment name, then run
    1. `make deploy`
        1. this should be succeed so you see a new machine running, but it will 
        take a bit of time for it to setup and be ready for an SSH connection which is needed 
        to run the next setup command.
    1. `make setup`
    1. `make data`
1. now you should be able to 
    1. `make lab`

ABLE TO GET ENVIRONMENTS IN JUPYTER LAB AFTER THIS
https://ipython.readthedocs.io/en/stable/install/kernel_install.html#kernels-for-different-environments