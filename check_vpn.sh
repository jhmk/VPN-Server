#!/bin/bash
current_external_ip=$(curl ident.me --max-time 120)
public_ip=$(curl --interface eth0 ident.me --max-time 120)
echo $current_external_ip
echo $public_ip
if [ $current_external_ip = $public_ip ]; then
	sudo sh sendmail.sh
else
	echo "VPN is up and running"
fi
