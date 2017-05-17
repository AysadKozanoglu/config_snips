#!/bin/bash
host=$(hostname -f)
email=myemail@domain.comtld
CURRENT=$(df / | grep / | awk '{ print $5}' | sed 's/%//g')
THRESHOLD=90
text="On Host $host root partition Disk Space critically low. $CURRENT % full"
if [ "$CURRENT" -gt "$THRESHOLD" ] ; then
    mail -s 'Disk Space Alert' $email $text
fi
