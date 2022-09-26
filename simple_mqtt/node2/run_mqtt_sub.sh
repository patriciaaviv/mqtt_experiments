#!/bin/bash

echo "Starting the mosquitto server now ..."
# cd into where my repo is
cd mqtt/mosquitto/client
make
$TOPIC=test
$HOST=172.16.2.1 #riga
./mosquitto_sub -p 1883 -t $TOPIC -h $HOST