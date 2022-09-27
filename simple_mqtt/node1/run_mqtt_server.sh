#!/bin/bash

#local="/root/mqtt"
# exit on error
set -e
# log every command
set -x

# clone git repo
repository="https://github.com/patriciaaviv/mosquitto.git"
# which folder is mine on the test node?
mkdir mqtt
localFolder="/root/mqtt/mosquitto"
git clone "$repository" "$localFolder"

echo "Starting the mosquitto server now ..."

# cd into where my repo is
#echo "current dir is $PWD", current dir is /root
#DIR= "$(pwd)/mqtt/mosquitto/src"
#cd $DIR
cd mqtt/mosquitto/src/
ls -la #1>&2
make 
./mosquitto -v

# TODO: also run something like tshark or tcpdump?