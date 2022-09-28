#!/bin/bash

# Simple experiment to test standard mosquitto server/client configuration

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
pos nodes reset $NODE1 
pos nodes reset $NODE2 

echo "nodes booted successfully"

# TODO: setup nodes
#pos commands launch -i node1/setup.sh --queued --name setup $NODE1
#pos commands launch -i node2/setup.sh --queued --name setup $NODE2


# TODO: execute experiment on nodes
pos commands launch --infile node1/run_mqtt_server.sh --queued -v --name run_mqtt_server $NODE1
pos commands launch --infile node2/run_mqtt_sub.sh --queued -v --name run_mqtt_sub $NODE2

echo "finished setting up the nodes"
