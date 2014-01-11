#!/bin/bash

shopt -s nullglob
dir="./data_subset"
out_dir="./freq_count_data"
# store all file names in a bash array
files=( "$dir"/* ) 
fileno=${#files[*]}

for ((j=0; j < ${fileno}; j++));
do 
	arr=($(head -1 ${files[$j]} | tr "," "\n"))
	arrLen=${#arr[*]}
	col=-99

	for ((i=0; i < ${arrLen}; i++)); 
	do 
		x=${arr[$i]}
		if [ $x == "ArrDelay" ] || [ $x == "\"ARR_DELAY\"" ]; then 
			# definition of column count is off by 1 between bash array and cut 
			col=$i
			(( col += 1 ))
			break
		fi
	done

	time cut -d',' -f${col} ${files[$j]} | sort -n | uniq -c > ${j}.txt 
done
