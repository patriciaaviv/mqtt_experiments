#!/bin/bash

echo "Setting up server node ..."

# exit on error
set -e
# log every command
set -x

apt-get update -y

DEBIAN_FRONTEND=noninteractive apt-get -y install tshark linux-perf libssl-dev nmap telnet net-tools ufw build-essential gcc make cmake git

mkdir mqtt
cd mqtt
git clone https://github.com/eclipse/mosquitto.git
cd mosquitto/src
make WITH_DOCS=no
# cp src/mosquitto ../..
cd /root

# mosquitto user
adduser --disabled-password --gecos "" mosquitto

ufw allow 22
ufw allow 1883 
ufw enable

echo "setup of server node completed"

