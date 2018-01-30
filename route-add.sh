#!/bin/bash
sudo route add default dev tunVPN
sudo route add -host resolver1.opendns.com dev tunVPN
sudo route add -host resolver2.opendns.com dev eth0
sudo route add -host *.archive.ubuntu.com dev eth0
sudo route add -net SERVERIP eth0
