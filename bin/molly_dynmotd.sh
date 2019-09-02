#!/bin/bash
 
PROCCOUNT=`ps -l | wc -l`
PROCCOUNT=`expr $PROCCOUNT - 4`
 
# get the load averages
read one five fifteen rest < /proc/loadavg
 
echo -e "\033[1;32m

               .__  .__         
  _____   ____ |  | |  | ___.__.
 /     \ /  _ \|  | |  |<   |  |
|  Y Y  (  <_> )  |_|  |_\___  |
|__|_|  /\____/|____/____/ ____|
      \/                 \/     

\033[0;37m 
+++++++++++++++++: System Data :+++++++++++++++++++
+ Hostname   = `hostname`
+ Address    = `ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/'`
+ Kernel     = `uname -r`
+ Uptime     =`uptime | sed 's/.*up ([^,]*), .*/1/'`
+ Date       = `date +"%A, %e %B %Y, %r"`
+ Free Space = `df -h / | awk -v col=4 'NR > 1 {sub( "%", "", $col); print $col }'`
+ Memory     = `cat /proc/meminfo | grep MemFree | awk {'print $2'}`kB (Free) / `cat /proc/meminfo | grep MemTotal | awk {'print $2'}`kB (Total)
+ Load Avg   = ${one}, ${five}, ${fifteen} (1, 5, 15 min)
+ IP         = `/sbin/ifconfig wlan0 | grep inet | awk -F" " {'print $2'} | head -1`
++++++++++++++++++: User Data :++++++++++++++++++++
+ Username   = `whoami`
+ Sessions   = `who | grep $USER | wc -l`
+++++++++++++++++++++++++++++++++++++++++++++++++++
"
