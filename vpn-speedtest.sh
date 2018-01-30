#!/bin/bash

# select Speedtest Server
SLS=$(speedtest --list | grep YOURNEARESTCITY | grep -Eo '[0-9]{1,4}' | head -1)

# do speedtest and collect datasudo
sudo speedtest --server $SLS --csv --timeout 30 > speedtest-csv-full.txt

# remove content that trigger error
awk -F 2017 '{ print $2 }' speedtest-csv-full.txt > speedtest-csv.txt


# get response time aka ping
RESPONSE=$(awk -F, '{ print $3 }' speedtest-csv.txt)

# get response timestamp
TIMESTAMP=$(date +"%Y-%m-%d"T"%H:%M:%S")

# get response download
DOWNLOAD=$(awk -F, '{ print $4 }' speedtest-csv.txt)

# get response upload
UPLOAD=$(awk -F, '{ print $5 }' speedtest-csv.txt)

# get VPN IP
VPNIP=$(curl ident.me --max-time 30)

# vpnname
VPNNAME="VPNSERVER1"

# vpn connected
VPNIPTEST=$(dig +short myip.opendns.com @resolver1.opendns.com)
if [ $VPNIPTEST = EXTERNALIP ]; then
	VPNON="NO"
		else
	VPNON="YES"
fi

# upload to MySQL DB

echo "INSERT INTO vpnstats (RESPONSE,TIMESTAMP,DOWNLOAD,UPLOAD,VPNIP,PROXYNAME,VPNON) VALUES ('$RESPONSE','$TIMESTAMP','$DOWNLOAD','$UPLOAD','$VPNIP','$PROXYNAME','$VPNON');" | mysql -uDBUSER -pPASSWORD DBNAME -h DBSERVER;

# empty results
sudo truncate -s 0 speedtest-csv.txt
sudo truncate -s 0 speedtest-csv-full.txt
