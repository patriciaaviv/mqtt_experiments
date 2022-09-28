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

chmod +x *.sh

echo "setup of client node completed"
