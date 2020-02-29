#!/bin/bash

for ((i=1; i<20;i++))
do
	wget -O pdkt_kusuma_$i -o asd.log  https://loremflickr.com/320/240/cat 
	cat asd.log >> wget.log
done
	cat wget.log | grep Location: > location.log
#cat location.log

mkdir duplicate 
mkdir kenangan

awk '{ printf("%s;%02d\n", $2, i + 1); i += 1 }' location.log | sort -n -k1 > file.log
count1=$(ls duplicate/ |awk -F '_' '{print $2}' | sort -rn | head -1)
count2=$(ls kenangan/ |awk -F '_' '{print $2}' | sort -rn | head -1)
awk -F ';' -v count1=$count1 -v count2=$count2 '{ i = $2+0; 
		if( L == $1 ){ 
			
			move = " mv pdkt_kusuma_" i " duplicate/duplicate_" count1+1; count1++; } 
  		else {
			  L = $1; 
			
			  move = " mv pdkt_kusuma_" i " kenangan/kenangan_" count2+1 ; count2++; }
				system(move); }' file.log 

for namafile in *.log; 
do 
	mv "$namafile" "${namafile%.log}.log.bak"
done 
