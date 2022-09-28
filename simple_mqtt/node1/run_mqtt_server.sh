#!/bin/bash

echo "Setting up server node ..."

# exit on error
set -e
# log every command
set -x

# configure mosquitto broker to allow remote connections
echo "listener 1883 172.16.2.1" >> /root/mqtt/mosquitto/mosquitto.conf
echo "allow_anonymous true" >> /root/mqtt/mosquitto/mosquitto.conf


echo "Starting the mosquitto server now ..."
# write server output into a txt file
cd /root/mqtt/mosquitto/src
./mosquitto -v -c /root/mqtt/mosquitto/mosquitto.conf >> /root/mqtt_server_output.txt

