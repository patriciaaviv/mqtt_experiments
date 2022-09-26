#!/bin/bash

hn=$(pos_get_variable hostname)
a_global_variable=$(pos_get_variable a/global/variable --from-global)
a_local_variable=$(pos_get_variable a/local/variable)

echo "Setting up node2..."
echo "hostname is $hn according to pos"

apt-get install tshark
apt-get install nftables
apt-get install libssl-dev

# clone git repo
repository="https://github.com/patriciaaviv/mosquitto.git"
# which folder is mine on the test node?
mkdir mqtt
localFolder="/root/mqtt/mosquitto"
git clone "$repository" "$localFolder"

# set up interfaces
$IFACE1="eno1"
ip link set dev $IFACE1 up

# include iptables rule to randomize IP address
iptables -t nat -A POSTROUTING -o $IFACE1 -p tcp -m tcp --syn -m statistic --mode random --probability 0.5 -j SNAT --to-source 172.16.1.1
#iptables -t nat -A POSTROUTING -o $IFACE1 -m statistic --mode nth --every 1 --packet 0 -j SNAT --to-source 172.16.1.1

echo "setup of client node completed"
