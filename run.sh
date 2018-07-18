#!/bin/bash

HOSTNAME=`hostname`

git -C unisrt pull
git -C topology pull

sudo mkdir /data
sudo mkdir /data/db
sudo mkdir /data/db/log

sudo -E /etc/init.d/supervisor start
sudo service supervisor restart
sudo lldpd -i eth0
sudo snmpd 
echo "SDN Controller IP : `hostname --ip-address`"
tail -f /var/log/ryu.log

