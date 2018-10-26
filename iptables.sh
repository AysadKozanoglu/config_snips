#!/bin/sh
 
#####################################################
# IPTables Firewall-Skript                          #
# Author: Aysad Kozanoglu			                        #
# usage:  iptables.sh start|stop                    #
#####################################################
 
# iptables suchen
iptables=`which iptables`
     NIC=eth0

# wenn iptables nicht installiert abbrechen
test -f $iptables || exit 0
 
case "$1" in
   start)
      echo "Starte Firewall..."
      # alle Regeln löschen
      $iptables -t nat -F
      $iptables -t filter -F
      $iptables -X
 
      # neue Regeln erzeugen
      $iptables -N garbage
      $iptables -I garbage -p TCP -j LOG --log-prefix="DROP TCP-Packet: " --log-level info
      $iptables -I garbage -p UDP -j LOG --log-prefix="DROP UDP-Packet: " --log-level info
      $iptables -I garbage -p ICMP -j LOG --log-prefix="DROP ICMP-Packet: " --log-level info
 
      # Default Policy
      $iptables -P INPUT DROP
      #$iptables -P OUTPUT DROP
      $iptables -P OUTPUT ACCEPT
      $iptables -P FORWARD DROP
 
      # über Loopback alles erlauben
      $iptables -I INPUT -i lo -j ACCEPT
      $iptables -I OUTPUT -o lo -j ACCEPT

      #####################################################
      # NUR wenn oben $iptables -P OUTPUT DROP - eingestellt ist 
      # ausgehende Verbindungen
      # Port 123
      # $iptables -I OUTPUT -o eth0 -p TCP --sport 1024:65535 --dport 123 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
      # $iptables -I INPUT -i eth0 -p TCP --sport 123 --dport 1024:65535 -m state --state ESTABLISHED,RELATED -j ACCEPT
      # $iptables -I OUTPUT -o eth0 -p UDP --sport 1024:65535 --dport 123 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
      # $iptables -I INPUT -i eth0 -p UDP --sport 123 --dport 1024:65535 -m state --state ESTABLISHED,RELATED -j ACCEPT
      # Port 443
      # $iptables -I OUTPUT -o eth0 -p TCP --sport 1024:65535 --dport 443 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
      # $iptables -I INPUT -i eth0 -p TCP --sport 443 --dport 1024:65535 -m state --state ESTABLISHED,RELATED -j ACCEPT

 
      #####################################################
      # eingehende Verbindungen
      # Port 80
      $iptables -I INPUT -i $NIC -p TCP --sport 1024:65535 --dport 80 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
      $iptables -I OUTPUT -o $NIC -p TCP --sport 80 --dport 1024:65535 -m state --state ESTABLISHED,RELATED -j ACCEPT
      # Port 22001
      $iptables -I INPUT -i $NIC -p TCP --sport 1024:65535 --dport 22001 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
      $iptables -I OUTPUT -o $NIC -p TCP --sport 22001 --dport 1024:65535 -m state --state ESTABLISHED,RELATED -j ACCEPT
      # Port 3306
     $iptables -I INPUT -i $NIC -p TCP --sport 1024:65535 -s 10.10.1.100 --dport 3306 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
     $iptables -I OUTPUT -o $NIC -p TCP --sport 3306 --dport 1024:65535 -m state --state ESTABLISHED,RELATED -j ACCEPT

      #####################################################
      # Erweiterte Sicherheitsfunktionen
      # SynFlood
      $iptables -A FORWARD -p tcp --syn -m limit --limit 1/s -j ACCEPT
      # PortScan
      $iptables -A FORWARD -p tcp --tcp-flags SYN,ACK,FIN,RST RST -m limit --limit 1/s -j ACCEPT
      # Ping-of-Death
      $iptables -A FORWARD -p icmp --icmp-type echo-request -m limit --limit 1/s -j ACCEPT
      # HTTP Limit pro Minute
      $iptables -A INPUT -i $NIC -p tcp --dport 80 -j LOG --log-prefix "Web Server Access" --log-level 6 -m limit --limit 200/m
 
      #####################################################
      # bestehende Verbindungen akzeptieren
      $iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
      $iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
 
      #####################################################
      # Garbage übergeben wenn nicht erlaubt
      $iptables -A INPUT -m state --state NEW,INVALID -j garbage
 
      #####################################################
      # alles verbieten was bisher erlaubt war
      $iptables -A INPUT -j garbage
      $iptables -A OUTPUT -j garbage
      $iptables -A FORWARD -j garbage
      ;;
   stop)
      echo "Stoppe Firewall..."
      $iptables -t nat -F
      $iptables -t filter -F
      $iptables -X
      $iptables -P INPUT ACCEPT
      $iptables -P OUTPUT ACCEPT
      $iptables -P FORWARD ACCEPT
      ;;
   restart|reload|force-reload)
   $0 stop
   $0 start
      ;;
   *)
      echo "Usage: iptables.sh (start|stop)"
      exit 1
      ;;
esac
exit 0
