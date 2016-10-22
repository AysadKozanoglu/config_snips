#! /bin/bash
#
# coder: Aysad Kozanoglu
# email : aysadx@gmail.com
# web: http://onweb.pe.hu
#

uname -s
uname -m
lsb_release -si
lsb_release -sr
lsb_release -sc
lsb_release -sd
echo ""
echo "network"
echo "-------"
ifconfig | grep encap
ifconfig | grep Bcast
