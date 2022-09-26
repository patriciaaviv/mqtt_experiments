#!/bin/bash

hn=$(pos_get_variable hostname)
a_global_variable=$(pos_get_variable a/global/variable --from-global)
a_local_variable=$(pos_get_variable a/local/variable)

echo "Setting up node2..."
echo "hostname is $hn according to pos"

# clone git repo
repository="https://github.com/patriciaaviv/mosquitto.git"
# which folder is mine on the test node?
mkdir mqtt
localFolder="/root/mqtt/"
git clone "$repository" "$localFolder"

# compile the files
cd /root/mqtt/
make

echo "setup of client node completed"

## add iptables rule here?