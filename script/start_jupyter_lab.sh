#!/usr/bin/env bash

export PATH=$PATH:/home/jupyter/.local/bin
. /home/jupyter/anaconda3/etc/profile.d/conda.sh
conda activate base

exec jupyter-lab --config='/home/jupyter/.jupyter/jupyter_notebook_config.py' --notebook-dir=/home/jupyter/workdir --port=8888 --no-browser --ip='0.0.0.0'

