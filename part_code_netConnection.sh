#!/bin/bash
#   Company: adelphi
#     coder: Aysad Kozanoglu
#     Stand: 13.04.17
#
#  letzte Änderung 24.04.17
#
#		Dieser Script wird von netConnection.sh aus ausgeführt und 
#		ist ein Teil von netConnection.sh
#
#   	 Beschreibung:
#        Ermittellt alle Verbindunden
#        und summiert den Anzahl basierend auf IP Verbindungen
#        somit ist zu erkennen ob,
#        eine connection FLood passiert
#
#		für überwachen minimum 20 verbindungen/ip
#   	part_code_netConnection.sh 20



tmp=/tmp/netconns
minlimit=10

if [ -n $1 ]
then
 minlimit=$1
fi

echo "min Limit: $minlimit"
echo ""
exec=$(netstat -atun | awk '{print $5}' | cut -d: -f1 | sed -e '/^$/d' |sort| uniq -c | sort -r > $tmp)

echo -e "Anzahl \t ip \t\t\t hosname"
echo "-----------------------------------------------------------------"

while read line
 do
    netcount=$(echo $line | awk '{print $1}')
          ip=$(echo $line | awk '{print $2}')
   #echo $c
    if (($netcount > $minlimit))
     then
        ip2host=$(host $ip | awk '{print $5}')
        if [ "$ip" != "0.0.0.0" ] && [ "$ip" != "127.0.0.1" ]
         then
          echo -e $netcount "\t" $ip "   \t" $ip2host
        fi
    fi
done < $tmp
