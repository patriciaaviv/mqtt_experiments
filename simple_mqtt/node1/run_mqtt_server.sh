#!/bin/bash

# exit on error
set -e
# log every command
set -x

# update apt-get 
apt-get update -y

DEBIAN_FRONTEND=noninteractive apt-get install tshark -y
DEBIAN_FRONTEND=noninteractive apt-get install libssl-dev -y

# clone git repo
repository="https://github.com/patriciaaviv/mosquitto.git"
# which folder is mine on the test node?
mkdir mqtt
localFolder="/root/mqtt/mosquitto"
git clone "$repository" "$localFolder"

echo "Starting the mosquitto server now ..."

# cd into where my repo is
cd mqtt/mosquitto/src/
ls -la #1>&2
make 
./mosquitto -v

# TODO: also run something like tshark or tcpdump?