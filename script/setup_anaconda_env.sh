#!/usr/bin/env bash

PYTHON_VERSION=3.8

JUPYTER_HOME=/home/jupyter
(

	cd ${JUPYTER_HOME}

	mv .bashrc .bashrc.back

	curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj bin/micromamba
	./bin/micromamba shell init -s bash -p ${JUPYTER_HOME}

	cat .bashrc .bashrc.back > .bashrc.new
	mv .bashrc.new .bashrc

	source .bashrc
	micromamba activate
	micromamba install mamba python=${PYTHON_VERSION} jupyterlab -c conda-forge
)
