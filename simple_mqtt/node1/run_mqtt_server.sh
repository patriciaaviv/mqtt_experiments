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
pwd
cd /root

# mosquitto user
adduser --disabled-password --gecos "" mosquitto

echo "setup of server node completed"

ufw allow 22
ufw allow 1883 
ufw enable

# configure mosquitto broker to allow remote connections
echo "listener 1883 172.16.2.1" >> /mqtt/mosquitto/mosquitto.conf
echo "allow_anonymous true" >> /mqtt/mosquitto/mosquitto.conf


echo "Starting the mosquitto server now ..."
# write server output into a txt file
cd mqtt/mosquitto/src
./mosquitto -v -c /mqtt/mosquitto/mosquitto.conf >> /root/mqtt_server_output.txt

