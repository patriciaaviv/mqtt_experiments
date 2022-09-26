#!/bin/bash

hn=$(pos_get_variable hostname)
a_global_variable=$(pos_get_variable a/global/variable --from-global)
a_local_variable=$(pos_get_variable a/local/variable)

echo "Setting up server node ..."
echo "hostname is $hn according to pos"

apt-get install tshark
apt-get install libssl-dev

# clone git repo
repository="https://github.com/patriciaaviv/mosquitto.git"
# which folder is mine on the test node?
mkdir mqtt
localFolder="/root/mqtt/mosquitto"
git clone "$repository" "$localFolder"

# compile the files
#cd /mqtt/mosquitto
#make

echo "setup of server node completed"

