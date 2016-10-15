 #!/bin/sh

# iptables script generated 2016-03-03
# http://www.kozanoglu.de



IPT="/sbin/iptables"


# Flush old rules, old custom tables
$IPT --flush
$IPT --delete-chain

# Set default policies for all three default chains
$IPT -P INPUT DROP

$IPT -P FORWARD DROP
$IPT -P OUTPUT ACCEPT

# Enable free use of loopback interfaces
$IPT -A INPUT -i lo -j ACCEPT
$IPT -A OUTPUT -o lo -j ACCEPT

# All TCP sessions should begin with SYN
$IPT -A INPUT -p tcp ! --syn -m state --state NEW -s 0.0.0.0/0 -j DROP


# Accept inbound TCP packets
$IPT -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
$IPT -A INPUT -p tcp --dport 22001 -m state --state NEW -s 0.0.0.0/0 -j ACCEPT
$IPT -A INPUT -p tcp --dport 8080 -m state --state NEW -s 0.0.0.0/0 -j ACCEPT
$IPT -A INPUT -p tcp --dport 1935 -m state --state NEW -s 0.0.0.0/0 -j ACCEPT

# Accept inbound ICMP messages
$IPT -A INPUT -p ICMP --icmp-type 8 -s 0.0.0.0/0 -j ACCEPT
$IPT -A INPUT -p icmp -m icmp --icmp-type 8 -m limit --limit 1/second -j ACCEPT

#syn flood attack
$IPT  -A INPUT -p tcp ! --syn -m state --state NEW -j DROP

#70 verbunden / min.
$IPT -A INPUT -p tcp --dport 8080 -m limit --limit 70/minute --limit-burst 100 -j ACCEPT
$IPT -A INPUT -p tcp --dport 1935 -m limit --limit 70/minute --limit-burst 100 -j ACCEPT
