#!/bin/bash

HOSTNAME=`hostname`

git -C unisrt pull
git -C topology pull

sudo supervisord
sudo -E /etc/init.d/supervisor start

sudo lldpd -i eth0
sudo snmpd 
echo "SDN Controller IP : `hostname --ip-address`"
tail -f /var/log/ryu.log

