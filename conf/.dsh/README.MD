
### dsh example config file

look also config path /etc/dsh/

put .dsh folder to your home directory 

todo on the client side:

modify the machines.list
moddify the group/group1

for all machines in the machines.list listed
``` dsh -M -c -a  " uptime > /tmp/t; free -m >> /tmp/t; cat /tmp/t"```

group based 
``` dsh -M -c -g group1  " uptime > /tmp/t; free -m >> /tmp/t; cat /tmp/t"```

