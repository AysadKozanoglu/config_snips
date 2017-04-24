#!/bin/bash
#
#   auto detetion and blocking 
#  source of flooting ip adress
#
#      by Aysad Kozanoglu
#   email: aysadx@gmail.com
#
#  manually unblock the blocked source ip:
#
#   1. iptables -L -n -v --line-numbers | grep 37.221.55.33
#      -> the first gives you the line number
#
#   2. iptables -D INPUT 43
#      -> delete the rule on line 43 
#

n=$(netstat -atun | awk '{print $5}' | cut -d: -f1 | sed -e '/^$/d' |sort | uniq -c | sort -r)

# max connections allowed
burst=50
nextBan=0
IPT=$(which iptables)
for k in $n
do
	#echo $k
	# iptable rule to block ip 
    if [ "$nextBan" == 1 ] 
	then
		#Get the first block of ip adress to block whole /16 subnet source adresses
		subnet=$(echo $k | cut -d. -f1-2)
		$IPT -I INPUT -s $subnet.0.0/16 -j DROP
		nextBan=0
		$IPT --list | grep DROP
    fi
	if [ "$k" -eq "$k" ] 2>/dev/null; 
	then
    	if(($k > $burst)) 
		then
    		# next ip has to ban on next round of step
			nextBan=1
    	fi
	fi
done
exit
