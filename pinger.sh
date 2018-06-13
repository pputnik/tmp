#!/bin/bash 

#num=$(( ( RANDOM % 10 )  + 1 ))
#echo $num
if [ $(/bin/netstat -plnt | /bin/grep ":25 " -c) -ne 2 ]; then num=0; else num=1; fi
echo "`date '+%Y-%m-%d %H:%M:%S'` $num" >> /var/log/num.log
