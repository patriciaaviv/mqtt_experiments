#!/bin/bash

echo "Setting up server node ..."

# exit on error
set -e
# log every command
set -x

# update apt-get 
apt-get update -y

DEBIAN_FRONTEND=noninteractive apt-get install tshark -y
DEBIAN_FRONTEND=noninteractive apt-get install libssl-dev -y

echo "setup of server node completed"

