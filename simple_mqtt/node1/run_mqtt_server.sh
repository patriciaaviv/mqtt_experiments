#!/bin/bash

echo "Starting the mosquitto server now ..."
# cd into where my repo is
#echo "current dir is $PWD", current dir is /root
DIR= "$(pwd)/mqtt/mosquitto/src"
cd $DIR
make 
./mosquitto -v

# TODO: also run something like tshark or tcpdump?