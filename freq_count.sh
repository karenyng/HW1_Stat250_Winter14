#!/bin/bash

#---------------------------------------------------------------------------
# Author: Karen Ng
# This script 
# * reads in airline csv data files 
# * finds the column that corresponds to delay time
# * cut the column then count the frequencies of a certain delay time
# * returns frequency count in files named 1.txt 2.txt etc. 
# * the frequency count files still has header and NA values mixed inside
# * have to use R or other language to discard those 
# version 1: no growing arrays but have extra I/O 
#---------------------------------------------------------------------------

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

			# if it is a monthly csv, have to add two to the column count for the
			# column value to be fetched correctly by cut. 
			# This is because some values in the monthly CSV contain commas
			if [ $x == "\"ARR_DELAY\"" ]; then 
				(( col += 2 ))
			fi

			break
		fi
	done

	echo "Writing the file-$j delay time to freq_count.txt"
	# store the frequency count of all the csv files in one single file
	# possible time improvement: 
	# use an array to hold these instead of writing it to a file first 
	# the col-finding and the writing out takes around 1 min 8 s real time  
	if [ $j -eq 0 ]; then 
		cut -d',' -f${col} ${files[$j]} > freq_count.txt 
	else 
		cut -d',' -f${col} ${files[$j]} >> freq_count.txt 
	fi

done

echo "starting to sort all the frequency to sorted_freq.txt"
# output of (time)
# real	3m14.067s
# user	3m7.896s
# sys	0m5.388s
time cat freq_count.txt | sort -n | uniq -c > sorted_freq.txt 

# remove header lines from sorted_freq.txt
sed --in-place='.bak' -e '/ArrDelay/d' -e '/ARR_DEL15/d' sorted_freq.txt
rm *.bak


