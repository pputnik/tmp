#!/bin/bash

num=$(( ( RANDOM % 10 )  + 1 ))
#echo $num
echo "{\"key\":$num,\"key2\":$num$num}"