#!/bin/bash

echo "Starting the mosquitto server now ..."
# cd into where my repo is
pwd
cd src
make
./mosquitto -c mosquitto.conf -v

# TODO: also run something like tshark or tcpdump?