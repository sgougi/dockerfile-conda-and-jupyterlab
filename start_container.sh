#!/usr/bin/env sh
exec docker run -it -p 222:22 -p 8888:8888 --rm --name anaconda --mount type=bind,src=`pwd`/workdir,dst=/home/jupyter/workdir anaconda

