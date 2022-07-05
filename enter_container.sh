#!/bin/sh
cd $(dirname $0)
exec docker exec -i -t anaconda su - jupyter
