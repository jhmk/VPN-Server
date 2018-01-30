#!/bin/bash

# fetch ip address and default gateway.
ip=$( ip addr show dev eth0 |grep "inet " | awk '{print $2}' | cut -d '/' -f 1 )
# default gateway.
dgw=$( ip route |grep "default via " | awk '{print $3}')

ip rule | grep -q "from $ip" || sudo ip rule add from $ip table vpn
ip rule | grep -q 0x1 || sudo ip rule add fwmark 0x1 lookup vpn && sudo ip rule add to LOCALIP/12 table vpn
ip route show table vpn |grep -q $dgw || sudo ip route add default via $dgw table vpn && ip route add LOCALIP/20 dev eth0 src $ip table vpn

#VPN OVPNs
ovpn=$(find * -type f -name "VPNPROVIDER.ovpn")

while true; do # Entering one infinite loop
	for conf in $ovpn; do
	timeout $(( 24*3600 ))	sudo openvpn --ping restart --config $conf --auth-user-pass VPNPROVIDER.pass --dev tunVPN --ca VPNPROVIDER.crt --script-security 2
	done
done
