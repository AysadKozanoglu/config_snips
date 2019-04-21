#!/bin/sh

# Author: Aysad Kozanoglu
# wget -O iptables_nmap_ping_prevention.sh "https://git.io/fjONK"; chmod +x iptables_nmap_ping_prevention.sh; /bin/sh iptables_nmap_ping_prevention.sh

# prevention against NMAP scan, ping, udp floods 

iptables=`which iptables`


# Log attacks
$iptables -A INPUT -p tcp --tcp-flags ALL FIN,PSH,URG -m limit --limit 3/m --limit-burst 5 -j LOG --log-prefix "Firewall> XMAS scan "
$iptables -A INPUT -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -m limit --limit 3/m --limit-burst 5 -j LOG --log-prefix "Firewall> XMAS-PSH scan "
$iptables -A INPUT -p tcp --tcp-flags ALL ALL -m limit --limit 3/m --limit-burst 5 -j LOG --log-prefix "Firewall> XMAS-ALL scan "

# Drop and blacklist for 60 seconds IP of attacker
$iptables -A INPUT -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -m recent --name blacklist_60 --set  -m comment --comment "Drop/Blacklist Xmas/PSH scan" -j DROP 

# Xmas-PSH scan
$iptables -A INPUT -p tcp --tcp-flags ALL FIN,PSH,URG -m recent --name blacklist_60 --set  -m comment --comment "Drop/Blacklist Xmas scan" -j DROP # Against nmap -sX (Xmas tree scan)

$iptables -A INPUT -p tcp --tcp-flags ALL ALL -m recent --name blacklist_60 --set  -m comment --comment "Drop/Blacklist Xmas/All scan" -j DROP # Xmas All scan

#Log attack
$iptables -A INPUT -p tcp --tcp-flags ALL FIN -m limit --limit 3/m --limit-burst 5 -j LOG --log-prefix "Firewall> FIN scan "

# Drop and blacklist for 60 seconds IP of attacker
$iptables -A INPUT -p tcp --tcp-flags ALL FIN -m recent --name blacklist_60 --set  -m comment --comment "Drop/Blacklist FIN scan" -j DROP


# log  probable sS and full connect tcp scan
$iptables -A INPUT -p tcp  -m multiport --dports 23,79 --tcp-flags ALL SYN -m limit --limit 3/m --limit-burst 5 -j LOG --log-prefix "Firewall>SYN scan trap:" 

# blacklist for three minuts
$iptables -A  INPUT -p tcp  -m multiport --dports 23,79 --tcp-flags ALL SYN -m recent --name blacklist_180 --set -j DROP

$iptables -A INPUT -p udp  -m limit --limit 6/h --limit-burst 1 -m length --length 0:28 -j LOG --log-prefix "Firewall>0 length udp "

$iptables -A INPUT -p udp -m length --length 0:28 -m comment --comment "Drop UDP packet with no content" -j DROP
