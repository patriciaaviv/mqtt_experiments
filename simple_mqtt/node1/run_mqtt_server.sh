#!/bin/bash

echo "Starting the mosquitto server now ..."
# cd into where my repo is
cd /root/mqtt/mosquitto/src
make
./root/mqtt/mosquitto/src/mosquitto -c mosquitto.conf -v

# TODO: also run something like tshark or tcpdump?