#!/usr/bin/env sh


exists=$(docker container ls -a |  awk '{print $2}' | grep -E "^anaconda$" | wc -l)

if [ $exists = "1" ] ; then
 docker start anaconda -i
 exit 0
fi
 


vghost_ip=$(netstat -rn | grep "^0.0.0.0 " | cut -d " " -f10)

echo "vghost_ip=$vghost_ip"
cd $(dirname $0)
#exec docker run --add-host=vghost:$vghost_ip -it -p 222:22 -p 8888:8888 --rm --name anaconda --mount type=bind,src=`pwd`/workdir,dst=/home/jupyter/workdir anaconda

exec docker run --add-host=vghost:$vghost_ip -it -p 222:22 -p 8888:8888 --name anaconda --mount type=bind,src=`pwd`/workdir,dst=/home/jupyter/workdir anaconda

