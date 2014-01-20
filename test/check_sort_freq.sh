#!/bin/bash

# pipe the content of frequency count to sed 
# use sed to remove the trailing decimal places for some delay time entries
# sort them then find unique counts 
# remove header --- could have just used grep -v  
cat freq_count.txt | sed -E 's/([0-9]+)\.00/\1/g' |\
	sort -n | uniq -c |\
	sed -e '/ArrDelay/d' -e '/ARR_DEL15/d' > sorted_freq.txt
