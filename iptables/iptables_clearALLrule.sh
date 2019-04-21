#!/bin/sh

# Author: Aysad Kozanoglu
# wget -O iptables_clearALLrule.sh "https://git.io/fjON4"; /bin/sh iptables_clearALLrule.sh

# Clear all iptables rules

iptables=`which iptables`

## CLEAR ALL iptables BEFORE
$iptables -t nat -F
$iptables -t filter -F
$iptables -X
$iptables -P INPUT ACCEPT
$iptables -P OUTPUT ACCEPT
$iptables -P FORWARD ACCEPT

echo ""
echo "iptables cleared successfully. no rules more.. "
echo ""
