# Kill active VPN Connections
ps -ef | grep vpn | grep -v grep | awk '{print $2}' | xargs sudo kill -SIGSTOP 
ps -ef | grep vpn | grep -v grep | awk '{print $2}' | xargs sudo kill -9

sudo truncate -s 0 nohup.out
# restart VPN

#sudo nohup sh start-vpn.sh &
