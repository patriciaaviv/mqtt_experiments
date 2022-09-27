#!/bin/bash

local="/root/mqtt"
# exit on error
set -e
# log every command
set -x

echo "Starting the mosquitto server now ..."


# cd into where my repo is
#echo "current dir is $PWD", current dir is /root
#DIR= "$(pwd)/mqtt/mosquitto/src"
#cd $DIR
cd $local/mosquitto/src/
ls -la #1>&2
make 
./mosquitto -v

# TODO: also run something like tshark or tcpdump?