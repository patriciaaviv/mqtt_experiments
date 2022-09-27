#!/bin/bash

# exit on error
set -e
# log every command
set -x

# update apt-get 
apt-get update -y

DEBIAN_FRONTEND=noninteractive apt-get install tshark -y
DEBIAN_FRONTEND=noninteractive apt-get install libssl-dev -y
DEBIAN_FRONTEND=noninteractive apt-get install nmap -y
DEBIAN_FRONTEND=noninteractive apt-get install telnet -y
DEBIAN_FRONTEND=noninteractive apt-get install net-tools -y

# # clone git repo
# repository="https://github.com/patriciaaviv/mosquitto.git"
# mkdir mqtt
# localFolder="/root/mqtt/mosquitto"
# git clone "$repository" "$localFolder"

DEBIAN_FRONTEND=noninteractive apt-get install mosquitto -y

ufw allow 1883 
ufw enable

# configure mosquitto broker to allow remote connections
echo "listener 1883 172.16.2.1" >> /etc/mosquitto/mosquitto.conf
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
