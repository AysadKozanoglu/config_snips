#!/bin/sh

# Author: Aysad Kozanoglu 
# wget -O iptables_dnsRefl_prevention.sh "https://git.io/fjONu"; chmod +x iptables_dnsRefl_prevention.sh; /bin/sh iptables_dnsRefl_prevention.sh

# Prorectiong DNS server against DNS reflections 

iptables=`which iptables`

$iptables -N udp-flood
$iptables -A udp-flood -m limit --limit 4/second --limit-burst 4 -j RETURN
$iptables -A udp-flood -j DROP
$iptables -A INPUT -i eth0 -p udp -j udp-flood
$iptables -A INPUT -i eth0 -f -j DROP
$iptables -N DNSAMPLY
$iptables -A DNSAMPLY -p udp -m state --state NEW -m udp --dport 53 -j ACCEPT
$iptables -A DNSAMPLY -p udp -m hashlimit --hashlimit-srcmask 24 --hashlimit-mode srcip --hashlimit-upto 30/m --hashlimit-burst 10 --hashlimit-name DNSTHROTTLE --dport 53 -j ACCEPT
$iptables -A DNSAMPLY -p udp -m udp --dport 53 -j DROP
#$iptables -A INPUT -p udp -m string —hex-string "|03697363036f726700|" —algo bm —to 65535 -j DROP 
$iptables -A INPUT -p udp -m udp --dport 53 -m limit --limit 5/sec -j LOG --log-prefix "fw-dns-attack" --log-level 7

echo ""
echo "DNS reflection Protection rules enabled successfully"
echo ""
