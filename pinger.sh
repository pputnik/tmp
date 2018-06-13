#!/bin/bash 

#num=$(( ( RANDOM % 10 )  + 1 ))
#echo $num
num=if [ $(/usr/bin/netstat -plnt | /usr/bin/grep ":25 " -c) -ne 2 ]; then echo 0; else echo 1; fi
echo "`date '+%Y-%m-%d %H:%M:%S'` $num" >> /var/log/num.log
