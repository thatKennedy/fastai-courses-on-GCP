# conda for some reason isn't on the path when ssh'ing
CONDA="/opt/anaconda3/bin/conda"
# name is taken from the environoment.yml file
ENV="fastai"
PYTHON_ENV = /opt/anaconda3/envs/$ENV/bin/python

/opt/anaconda3/bin/conda update conda -y

if [ ! -d fastai ] ; then
    git clone https://github.com/fastai/fastai.git
fi

cd fastai; $CONDA env create -f environment.yml
$CONDA install ipykernel -n $ENV -y
$PYTHON_ENV -m ipykernel install --user --name myenv --display-name "Python ($ENV)"
