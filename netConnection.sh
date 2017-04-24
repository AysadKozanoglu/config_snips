#!/bin/bash
#   Company: adelphi
#     coder: Aysad Kozanoglu
#         Stand: 13.04.17
#
#        Ermittellt alle Verbindunden
#        und summiert den Anzahl basierend auf IP Verbindungen
#        somit ist zu erkennen ob,
#        eine connection FLood passiert
#
#		Ausführung:
#		Zum Überwachen minimum 20 Verbindungen/ip
#		netConnection.sh 20
#
#		standart ist 10

limit=10

if [ -z $1 ]
then
 echo -e "\e[91mFehler: Limit parameter fehlt\e[0m"
 echo -e "\e[92mBeispiel: $0 20 \e[0m"
exit 0
fi

if [ -n $1 ]
then
  limit=$1
fi

watch /usr/local/sbin/part_code_netConnection.sh $limit
