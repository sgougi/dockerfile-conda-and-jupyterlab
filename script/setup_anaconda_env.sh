#!/usr/bin/env bash

ANACONDA3_VER="2021.05"

export PATH=$PATH:/home/jupyter/.local/bin

install -m 0700 -d ~/.ssh

cat ~/jupyter_rsa.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
rm ~/jupyter_rsa.pub

pip install --upgrade pip

#pip install --upgrade pip && \
#pip install autopep8 && \
#pip install Keras && \
#pip install tensorflow 

######### INSTALL ANACONDA
cd /tmp && curl -O https://repo.anaconda.com/archive/Anaconda3-${ANACONDA3_VER}-Linux-x86_64.sh
/bin/bash /tmp/Anaconda3-${ANACONDA3_VER}-Linux-x86_64.sh -b
rm /tmp/Anaconda3-${ANACONDA3_VER}-Linux-x86_64.sh
####
cat << EOF >> ~/.bashrc
. /home/jupyter/anaconda3/etc/profile.d/conda.sh
conda activate base
EOF
####
. /home/jupyter/anaconda3/etc/profile.d/conda.sh
conda activate base
