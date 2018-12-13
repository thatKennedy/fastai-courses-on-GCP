
if [ ! -d data ] ; then
    mkdir data
    cd data
    wget http://files.fast.ai/data/dogscats.zip
    unzip -q dogscats.zip
    cd ../fastai/courses/dl1/
    ln -s ~/data ./
fi
