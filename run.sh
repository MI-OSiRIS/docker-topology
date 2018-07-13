#!/bin/bash

HOSTNAME=`hostname`

git -C unisrt pull
git -C topology pull

sudo touch /var/run/supervisor.sock
sudo mkdir /data
sudo mkdir /data/db
sudo mkdir /data/db/log

sudo mongod

sudo -E /etc/init.d/supervisor start
sudo lldpd -i eth0

echo "SDN Controller IP : `hostname --ip-address`"


