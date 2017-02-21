#!/bin/bash
logfile=/usr/local/nginx/html/firelogs.html 
d=$(date +%T)
echo "<html><body style='font-family:arial';font-size:'12px'><h2>BARBER's Firewall</h2> <br<br>Letzte Aktualisierung <b>"$d"</b><br> <pre>" > $logfile ;
/usr/sbin/logwatch --output stdout --format text --detail Med --service iptables --range today --filename /tmp/logwatch 
cat /tmp/logwatch >> $logfile
echo "</pre></body></html>" >> $logfile;
chown www-data:www-data $logfile
