#!/bin/bash

shopt -s nullglob
dir="./data"
# store all file names in a bash array
files=( "$dir"/* ) 
fileno=${#files[*]}

for ((j=1; j<${fileno}; j++));
do 

	arr=($(head -1 ${files[$j]} | tr "," "\n"))
	arrLen=${#arr[*]}

	col=-99
	for ((i=1; i <= ${arrLen}; i++)); 
	do 
		x=${arr[$i]}
		if [ $x == "ArrDelay" ] || [ $x == "\"ARR_DELAY\"" ]; then 
			col=$i
			break
		fi
	done
	echo "${files[$j]} $col"
	## time cut -d',' -f${col} ${1} | uniq -c  
done
