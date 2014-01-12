#!/bin/bash

#------------------------------------------------------------
# Author: Karen Ng
# This script 
# * reads in airline csv data files 
# * finds the column that corresponds to delay time
# * cut the column then count the frequencies of a certain delay time
# * returns frequency count in files named 1.txt 2.txt etc. 
# * the frequency count files still has header and NA values mixed inside
# * have to use R or other language to descard those 
#------------------------------------------------------------

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
			if [ $x == "\"ARR_DELAY\"" ]; then 
				(( col += 2 ))
			fi
			break
		fi
	done

	cut -d',' -f${col} ${files[$j]} > col${j}.txt 

done
