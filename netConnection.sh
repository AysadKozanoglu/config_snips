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

watch /usr/local/sbin/part_code_netConnection.sh $1
