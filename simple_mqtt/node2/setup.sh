#!/bin/bash

# exit on error
set -e
# log every command
set -x

echo "Setting up node2..."

# update apt-get 
apt-get update -y

DEBIAN_FRONTEND=noninteractive apt-get install tshark -y
DEBIAN_FRONTEND=noninteractive apt-get install libssl-dev -y

# # clone git repo
# repository="https://github.com/patriciaaviv/mosquitto.git"
# # which folder is mine on the test node?
# mkdir mqtt
# localFolder="/root/mqtt/mosquitto"
# git clone "$repository" "$localFolder"

# set up interfaces
$IFACE1="eno1"
ip link set dev $IFACE1 up

# use nftables instead of iptables
# normally the service is inactive, so enable it 
systemctl enable nftables.service
systemctl start nftables.service

# add the rule to nftables
# show all nftable rules with nft list ruleset

# load nftables config file
nft -f /etc/nftables.conf


# include iptables rule to randomize IP address
#iptables -t nat -A POSTROUTING -o $IFACE1 -p tcp -m tcp --syn -m statistic --mode random --probability 0.5 -j SNAT --to-source 172.16.1.1
#iptables -t nat -A POSTROUTING -o $IFACE1 -m statistic --mode nth --every 1 --packet 0 -j SNAT --to-source 172.16.1.1

echo "setup of client node completed"
