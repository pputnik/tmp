#!/bin/bash 

num=$(( ( RANDOM % 10 )  + 1 ))
echo $num
echo "`date +%Y-%m-%d:%H:%M:%S` $num some text here" >> /var/log/num.log