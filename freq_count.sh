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
# version 1: no growing arrays but have slow I/O 
#---------------------------------------------------------------------------

shopt -s nullglob
dir="./data"
out_dir="./freq_count_data"
# store all file names in a bash array
files=( "$dir"/* ) 
fileno=${#files[*]}

# loop through the files one by one
for ((j=0; j < ${fileno}; j++));
do 
	# look at the header, split them by "," 
	# store in array
	arr=($(head -1 ${files[$j]} | tr "," "\n"))
	arrLen=${#arr[*]}
	col=-99

	# loop through array of headers and count which column it is in  
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

	#echo "Writing the file-$j delay time to freq_count.txt"
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

#echo "starting to sort all the frequency to sorted_freq.txt"
# pipe the content of frequency count to sed 
# use sed to remove the trailing decimal places for some delay time entries
# sort them
# find unique counts 
# remove header --- could have just used "grep -v "  
cat freq_count.txt | sort -n | uniq -c |\
   	sed -e '/ArrDelay/d' -e '/ARR_DEL15/d' |\
	sed -E 's/([0-9]+)\.00/\1/g' 

# can output to a text file to check values 
#> sorted_freq.txt

