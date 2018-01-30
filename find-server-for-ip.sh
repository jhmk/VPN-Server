#!/bin/bash
truncate -s 0 vpn-list  && grep 'remote' ovpns/* | awk '{print $2}' > vpn-list | nmap -Pn -p 443 -iL vpn-list 
| grep IPYOULIKETOCHECK
