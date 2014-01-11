#!/bin/bash

echo "$(head -1 ${1})" | awk '{
	# read in header then split according to delimiter
	# storing number of columns in variable n 
	n=split($0, a, ","); 
	i=1;
	# traverse through the headers until a match
	while(a[i] != "ArrDelay" && a[i] != "\"ARR_DELAY\""){
		i++
		# save myself from infinite loop
		if (i == n){
			i = -99;
			break;
		}
	}
	print i
}'  
		
