#!/bin/bash

arr=($(head -1 ${1} | tr "," "\n"))
arrLen=${#arr[*]}

col=-99
for ((i=1; i <= ${arrLen}; i++)); 
do 
	x=${arr[$i]}
	echo $x
	if [ $x == "ArrDelay" ] || [ $x == "\"ARR_DELAY\"" ]; then 
		col=$i
		break
	fi
done
time cut -d',' -f${col} ${1} | uniq -c  
