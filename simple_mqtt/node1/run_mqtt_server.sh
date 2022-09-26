#!/bin/bash

echo "Starting the mosquitto server now ..."
# cd into where my repo is
#echo "current dir is $PWD", current dir is /root
DIR= "$(pwd)/mqtt/mosquitto/src"
cd $DIR
ls -la 1>&2
make 
./mosquitto -v

# TODO: also run something like tshark or tcpdump?