#!/bin/bash

# exit on error
set -e
# log every command
set -x

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

