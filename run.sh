#!/bin/bash

HOSTNAME=`hostname`

git -C unisrt pull
git -C topology pull

sudo mkdir -p /etc/ryu

sudo service supervisor start
sudo service lldpd start
sudo service snmpd start

echo "SDN Controller IP : `hostname --ip-address`"

while [ ! -f /var/log/ryu.log ]
do
	sleep 1
done
tail -f /var/log/ryu.log
