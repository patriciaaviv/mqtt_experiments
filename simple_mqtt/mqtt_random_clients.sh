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

# load loop variables
pos allocations set_variables $NODE2 --as-loop ./loop-variables.yml

# configure nodes
pos nodes image $NODE1 debian-bullseye
pos nodes image $NODE2 debian-bullseye

# reset/reboot nodes
pos nodes reset $NODE1 
pos nodes reset $NODE2 

echo "nodes booted successfully"

pos commands launch --infile node1/run_mqtt_server.sh --queued -v --name run_mqtt_server $NODE1
echo "start client with random ip addresses"
pos commands launch --infile node2/mqtt_sub_random_ip.sh --queued -v --loop --name mqtt_sub_random_ip $NODE2

echo "finished setting up the nodes"
