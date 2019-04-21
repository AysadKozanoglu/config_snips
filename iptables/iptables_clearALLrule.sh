#!/bin/sh
# Author: Aysad Kozanoglu
# 

iptables=`which iptables`

## CLEAR ALL iptables BEFORE
$iptables -t nat -F
$iptables -t filter -F
$iptables -X
$iptables -P INPUT ACCEPT
$iptables -P OUTPUT ACCEPT
$iptables -P FORWARD ACCEPT
