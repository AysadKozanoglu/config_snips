#!/bin/bash

bugun="bugun.html"
dun=/usr/local/nginx/html/mailstatus/dun.html
d=$(date +%T)

echo "<html><body style="font-family:Arial"> letzte aktualisierung "$d"<br><h1>MAIL statistik fuer <i>Gestern</i> </h1> <br><br><a href="$bugun"> >>HEUTE</a><pre>" > $dun
/usr/sbin/pflogsumm -d yesterday /var/log/mail.log >> $dun

echo "</pre></body></html>" >> $dun

exit 0;

