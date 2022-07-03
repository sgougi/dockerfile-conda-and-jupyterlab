#!/usr/bin/env bash

JUPYTER_HOME=/home/jupyter
(
	cd ${JUPYTER_HOME}
	source .bashrc
	micromamba activate

if  true ; then

	# Basic ML
    pip3 install japanize-matplotlib==1.1.3
    #	
	micromamba install \
                     arviz=0.11.2 \
                     pystan=2.19.1.1 \
                     xgboost=1.1.1 \
                     keras=2.4.3 \
                     tensorflow=2.4.1 \
                     mlxtend=0.19.0 \
                     pystan=2.19.1.1 \
                     fbprophet=0.7.1 \
	                 pydotplus \
	                 autopep8 \
	                 plotly \
	                 graphviz \
	                 python-graphviz \
	                 seaborn \
	                 -c conda-forge 2>&1| grep -v "Clobberwarning"

else

    # Basic ML + OpenPIV
    pip3 install japanize-matplotlib==1.1.3 opencv_contrib_python
    #
	micromamba install \
                     arviz=0.11.2 \
                     pystan=2.19.1.1 \
                     xgboost=1.1.1 \
                     keras=2.4.3 \
                     tensorflow=2.4.1 \
                     mlxtend=0.19.0 \
                     pystan=2.19.1.1 \
                     fbprophet=0.7.1 \
	                 pydotplus \
	                 autopep8 \
	                 openpiv=0.24.1 \
	                 plotly \
	                 graphviz \
	                 python-graphviz \
	                 seaborn \
                     openpiv \
	                 opencv \
	                 cython \
	                 pytube \
	                 -c conda-forge 2>&1| grep -v "Clobberwarning"
fi

)

