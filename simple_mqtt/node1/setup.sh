#!/bin/bash

echo "Setting up server node ..."

# exit on error
set -e
# log every command
set -x

# update apt-get 
apt-get update -y

apt-get install tshark
apt-get install libssl-dev


echo "setup of server node completed"

