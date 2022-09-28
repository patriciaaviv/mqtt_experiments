#!/bin/bash

# command needs to be called with two nodes
if test "$#" -ne 2; then
	echo "Usage: experiment.sh node1 node2"
	exit
fi

set -x # every executed command is printed to the shell for debugging
set -e # exit on error

NODE1=$1
NODE2=$2

# free nodes if already allocated
pos allocations free $NODE1
pos allocations free $NODE2

# allocate experiment nodes
pos allocations allocate --duration 100 $NODE1 $NODE2

# configure nodes
pos nodes image $NODE1 debian-bullseye
pos nodes image $NODE2 debian-bullseye

# reset/reboot nodes
pos nodes reset $NODE1 --non-blocking
pos nodes reset $NODE2 --non-blocking

echo "nodes booted successfully"

# setup nodes
# BROKER_SETUP_ID=$(pos commands launch -i node1/setup_broker.sh --queued -v --name setup $NODE1) 
# CLIENT_SETUP_ID=$(pos commands launch -i node2/setup_client.sh --queued -v --name setup $NODE2)

# pos commands await $BROKER_SETUP_ID
# pos commands await $CLIENT_SETUP_ID
#pos nodes copy $NODE1 node1/setup_broker.sh 
pos commands launch $NODE1 -i node1/setup_broker.sh -v --queued --name setup $NODE1

#pos nodes copy $NODE2 node2/setup_client.sh
pos commands launch $NODE2 -i node2/setup_client.sh -v --queued --name setup $NODE2


# # execute experiment on nodes
# COMMAND_BROKER_ID=$(pos commands launch --infile node1/run_mqtt_server.sh --queued -v --name run_mqtt_server $NODE1)
# # wait for broker to be running
# pos commands await $COMMAND_BROKER_ID
#pos commands launch --infile node2/run_mqtt_sub.sh --queued -v --name run_mqtt_sub $NODE2

#pos nodes copy $NODE1 node1/run_mqtt_server.sh 
pos commands launch $NODE1 -i node1/run_mqtt_server.sh -v --queued --name run_mqtt_server $NODE1

#pos nodes copy $NODE2 node2/run_mqtt_sub.sh
pos commands launch $NODE2 -i node2/run_mqtt_sub.sh -v --queued --name run_mqtt_sub $NODE2


echo "finished setting up the nodes"
