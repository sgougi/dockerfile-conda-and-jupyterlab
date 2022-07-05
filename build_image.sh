#!/usr/bin/env sh
cd $(dirname $0)
exec docker build -t anaconda .
