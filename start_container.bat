docker run -it -p 222:22 -p 8888:8888 --rm --name anaconda --mount type=bind,src=%CD%\workdir,dst=/home/jupyter/workdir anaconda

