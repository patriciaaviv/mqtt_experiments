#!/bin/bash

echo "Starting the mosquitto server now ..."
# cd into where my repo is
cd /root/mqtt/mosquitto
$TOPIC=test
$MSG=hello
$HOST=172.16.2.1 #riga
./client/mosquitto_pub -p 1883 -t $TOPIC -m "$MSG" -h $HOST
