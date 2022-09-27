#!/bin/bash

# exit on error
set -e
# log every command
set -x

# update apt-get 
# apt-get update -y

# DEBIAN_FRONTEND=noninteractive apt-get install tshark -y
# DEBIAN_FRONTEND=noninteractive apt-get install libssl-dev -y
echo "Starting the mosquitto server now ..."
# cd into where my repo is
cd mqtt/mosquitto/client
make
$TOPIC=test
$MSG=hello
$HOST=172.16.2.1 #riga
./mosquitto_pub -p 1883 -t $TOPIC -m "$MSG" -h $HOST
