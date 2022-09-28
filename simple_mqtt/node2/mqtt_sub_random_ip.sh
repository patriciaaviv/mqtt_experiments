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
DEBIAN_FRONTEND=noninteractive apt-get install nmap -y
DEBIAN_FRONTEND=noninteractive apt-get install telnet -y
DEBIAN_FRONTEND=noninteractive apt-get install net-tools -y

DEBIAN_FRONTEND=noninteractive apt-get install mosquitto-clients -y
DEBIAN_FRONTEND=noninteractive apt-get install iptables -y


# set up interfaces
$IFACE1="eno1"
ip link set dev $IFACE1 up

# use nftables instead of iptables
# normally the service is inactive, so enable it 
# systemctl enable nftables.service
# systemctl start nftables.service
systemctl enable iptables.service
systemctl start iptables.service

# add the rule to nftables
# show all nftable rules with nft list ruleset
# nft add table nat
# nft -- add chain nat prerouting { type nat hook prerouting priority -100 \; }
# nft add chain nat postrouting { type nat hook postrouting priority 100 \; }
# nft add rule nat postrouting oifname eno1 snat to numgen random mod 10 map { 0: 172.16.1.2, 1:172.16.1.254 }

# load nftables config file
#nft -f /etc/nftables.conf


# include iptables rule to randomize IP address
iptables -t nat -A POSTROUTING -o $IFACE1 -p tcp -m tcp --syn -m statistic --mode random --probability 0.5 -j SNAT --to-source 172.16.1.1
#iptables -t nat -A POSTROUTING -o $IFACE1 -m statistic --mode nth --every 1 --packet 0 -j SNAT --to-source 172.16.1.1

echo "setup of client node completed"

echo "Starting the mosquitto server now ..."
$TOPIC=test
$HOST=172.16.2.1 #riga
mosquitto_sub -p 1883 -t $TOPIC -h $HOST