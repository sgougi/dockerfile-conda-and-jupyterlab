#!/usr/bin/env bash

. /home/jupyter/anaconda3/etc/profile.d/conda.sh
conda activate base

############
conda config --append channels conda-forge
conda config --set channel_priority true
conda config --prepend repodata_fns repodata.json
############
conda install -c conda-forge mamba
mamba update -y --all 

###############
mamba install -y plotly
mamba install -y graphviz
mamba install -y python-graphviz
mamba install -y pydotplus
mamba install -y autopep8
mamba install -y japanize-matplotlib
##
mamba install -y arviz=0.11.2
mamba install -y pystan=2.19.1.1
mamba install -y fbprophet=0.7.1
mamba install -y xgboost=1.1.1
mamba install -y mlxtend=0.19.0
mamba install -y tensorflow=2.4.1
mamba install -y keras=2.4.3
##

