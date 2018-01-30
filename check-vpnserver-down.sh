#!/bin/bash
find * -type f -name "*.ovpn" > vpn-list
grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' ovpns/*.ovpn | cut -f2- -d: > vpn-ips
nmap -sn -oG - -v -iL vpn-ips | grep -n 'Down' | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}'  > vpn-downserver
if grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' "vpn-downserver"; then
grep -l -f "vpn-downserver" *.ovpn | xargs rm
truncate -s 0 vpn-downserver
truncate -s 0 vpn-ips
truncate -s 0 vpn-list
sudo find * -type f -name "*.ovpn" > vpn-list
ps -ef | grep vpn | grep -v grep | awk '{print $2}' | xargs sudo kill -SIGSTOP
ps -ef | grep vpn | grep -v grep | awk '{print $2}' | xargs sudo kill -9

else
	echo "all VPN Servers are reachable"
fi
