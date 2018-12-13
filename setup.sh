CONDA="/opt/anaconda3/bin/conda"
ENV="fastai"

/opt/anaconda3/bin/conda update conda

if [ ! -d fastai ] ; then
    git clone https://github.com/fastai/fastai.git
fi

cd fastai; $CONDA env create -f environment-cpu.yml
$CONDA install ipykernel -n $ENV -y
/opt/anaconda3/envs/$ENV/bin/python -m ipykernel install --user --name myenv --display-name "Python ($ENV)"
