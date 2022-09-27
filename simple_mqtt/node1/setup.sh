#!/bin/bash

echo "Setting up server node ..."

# exit on error
set -e
# log every command
set -x

# update apt-get 
apt-get update -y

apt-get install tshark
apt-get install libssl-dev

# clone git repo
repository="https://github.com/patriciaaviv/mosquitto.git"
# which folder is mine on the test node?
mkdir mqtt
localFolder="/root/mqtt/mosquitto"
git clone "$repository" "$localFolder"

echo "setup of server node completed"

