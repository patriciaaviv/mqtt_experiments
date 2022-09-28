#!/bin/bash

# exit on error
set -e
# log every command
set -x

echo "Setting up node2..."

# update apt-get 
apt-get update -y

DEBIAN_FRONTEND=noninteractive apt-get -y install tshark libssl-dev linux-perf tshark build-essential gcc make cmake git iptables

# clone mosquitto git repo
git clone https://github.com/eclipse/mosquitto.git
cd mosquitto
mkdir build
cd build

#cmake and make invocation: build static libraries
cmake -DWITH_STATIC_LIBRARIES=ON ..
make

#copy resulting library in the dir you were called from
cp lib/libmosquitto_static.a ../../libmosquitto.a

#make a "headers" folder in the dir you were called from and copy header files there
cd ../..
mkdir headers
cp mosquitto/lib/*.h headers/

gcc mosquitto_publisher.c libmosquitto.a -Iheaders -lcrypto -lssl -lpthread -o publisher
gcc mosquitto_subscriber.c libmosquitto.a -Iheaders -lcrypto -lssl -lpthread -o subscriber


# set up interfaces
$IFACE1="eno1"
ip link set dev $IFACE1 up

echo "setup of client node completed"


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
cd mosquitto/client
$TOPIC=test
$HOST=172.16.2.1 #riga
./mosquitto_sub -p 1883 -t $TOPIC -h $HOST