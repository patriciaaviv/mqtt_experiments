#!/bin/bash

echo "Starting the mosquitto server now ..."
# cd into where my repo is
cd /root/mqtt/mosquitto/client
make
$TOPIC=test
$HOST=172.16.2.1 #riga
./root/mqtt/mosquitto/client/mosquitto_sub -p 1883 -t $TOPIC -h $HOST