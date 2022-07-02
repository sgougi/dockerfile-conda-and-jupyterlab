#!/usr/bin/env bash
#PYTHON_VERSION="3.8"

. /home/jupyter/anaconda3/etc/profile.d/conda.sh
conda activate base

############
conda config --append channels conda-forge
conda config --set channel_priority true
conda config --prepend repodata_fns repodata.json
############

conda install -c conda-forge mamba

#mamba install -y python=${PYTHON_VERSION}

mamba install -y  plotly graphviz \
                 python-graphviz pydotplus autopep8 \
                 arviz pystan xgboost \
                 keras tensorflow mlxtend \
                 opencv openpiv cython \
                 pystan fbprophet

pip3 install japanize-matplotlib

mamba update -y --all 

