#!/bin/bash

# exit on error
set -e
# log every command
set -x

# update apt-get 
apt-get update -y

DEBIAN_FRONTEND=noninteractive apt-get install tshark -y
DEBIAN_FRONTEND=noninteractive apt-get install libssl-dev -y

# # clone git repo
# repository="https://github.com/patriciaaviv/mosquitto.git"
# # which folder is mine on the test node?
# mkdir mqtt
# localFolder="/root/mqtt/mosquitto"
# git clone "$repository" "$localFolder"

DEBIAN_FRONTEND=noninteractive apt-get install mosquitto -y

# configure mosquitto broker to allow remote connections
echo "listener 1883 0.0.0.0" >> /etc/mosquitto/mosquitto.conf
echo "allow_anonymous true" >> /etc/mosquitto/mosquitto.conf

echo "Starting the mosquitto server now ..."
# write server output into a txt file
mosquitto -v -c /etc/mosquitto/mosquitto.conf >> /root/mqtt_server_output.txt

# cd into where my repo is
# cd mqtt/mosquitto/src/
# ls -la #1>&2
# make 
# ./mosquitto -v

# TODO: also run something like tshark or tcpdump?
