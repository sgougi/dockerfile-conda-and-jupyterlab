#!/usr/bin/env bash

ANACONDA3_VER="2021.05"

export PATH=$PATH:/home/jupyter/.local/bin

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

