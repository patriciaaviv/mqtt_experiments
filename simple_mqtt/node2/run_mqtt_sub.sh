#!/bin/bash

# exit on error
set -e
# log every command
set -x

echo "Setting up node2..."

# update apt-get 
apt-get update -y

DEBIAN_FRONTEND=noninteractive apt-get install tshark -y
DEBIAN_FRONTEND=noninteractive apt-get install libssl-dev -y
DEBIAN_FRONTEND=noninteractive apt-get install nmap -y
DEBIAN_FRONTEND=noninteractive apt-get install telnet -y
DEBIAN_FRONTEND=noninteractive apt-get install net-tools -y

DEBIAN_FRONTEND=noninteractive apt-get install mosquitto-clients -y

# # # clone git repo
# repository="https://github.com/patriciaaviv/mosquitto.git"
# # which folder is mine on the test node?
# mkdir mqtt
# localFolder="/root/mqtt/mosquitto"
# git clone "$repository" "$localFolder"

# set up interfaces
$IFACE1="eno1"
ip link set dev $IFACE1 up

echo "setup of client node completed"

echo "Starting the mosquitto server now ..."
# cd into where my repo is
# cd mqtt/mosquitto/client
# make
$TOPIC=test
$HOST=172.16.2.1 #riga
mosquitto_sub -p 1883 -t $TOPIC -h $HOST