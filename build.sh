#!/bin/bash

echo "Building Ryu Container..."

sudo pip3 install ryu easysnmp

echo "Setting up UNIS-RT..."
cd lace
sudo python3 setup.py develop
cd -
cd unisrt
sudo python3 setup.py develop
cd -

echo "Setting up RYU..."
cd topology/ryu
sudo python3 setup.py develop
cd -

