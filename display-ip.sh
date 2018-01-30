echo "IP tunVPN via opendns"
dig +short myip.opendns.com @resolver1.opendns.com
echo "IP tunVPN via ident.me"
curl ident.me --max-time 60
echo "IP eth0 via opendns"
dig +short myip.opendns.com @resolver3.opendns.com
echo "IP eth0 via dns name"
host SERVERURL | awk '{ print $(NF) }'
