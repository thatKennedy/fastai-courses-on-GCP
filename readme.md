



1. install Make and gcloud commandline tools
1. create Google cloud account and project
1. Go to https://console.cloud.google.com/iam-admin/quotas?
    1. find "Compute Engine API: GPUs (all regions)"
    1. Check this quota and ask to edit edit quota
1. set up gcloud credentials from command line
1. update makefile with your project, zone, and deployment name

1. `make deploy`
1. `make update`
1. `make lab`
1. get your kaggle.json file into this direcotry [Instructions](https://github.com/Kaggle/kaggle-api)
    1. make sure you agree to any kaggle competitions first
    1. make the datasets, locally before pushing up 

ABLE TO GET ENVIRONMENTS IN JUPYTER LAB AFTER THIS
https://ipython.readthedocs.io/en/stable/install/kernel_install.html#kernels-for-different-environments