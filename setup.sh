# conda for some reason isn't on the path when ssh'ing
CONDA="/opt/anaconda3/bin/conda"
ENV="fastai"
PYTHON_ENV="/opt/anaconda3/envs/fastai/bin/python"

${CONDA} update conda -y
if [[ ! -d fastai ]] ; then
    git clone https://github.com/fastai/fastai.git
fi
cd fastai; ${CONDA} env create -f environment.yml
${CONDA} install ipykernel -n ${ENV} -y
${PYTHON_ENV} -m ipykernel install --user --name myenv --display-name "Python (${ENV})"
