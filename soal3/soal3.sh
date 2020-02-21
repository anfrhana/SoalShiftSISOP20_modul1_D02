#!/bin/bash

for ((i=1; i<29;i++))
do
	wget -O pdkt_kusuma_$i -o asd.log  https://loremflickr.com/320/240/cat 
	cat asd.log >> wget.log
done
	cat wget.log | grep Location: > location.log
#cat location.log

mkdir duplicate 
mkdir kenangan

awk '{ printf("%s;%02d\n", $2, i + 1); i += 1 }' location.log | sort -n -k1 > file.log

awk -F ';' '{ i = $2+0; 
		if( L == $1 ){ 
			move = " mv pdkt_kusuma_" i " duplicate/duplicate_" i; } 
  		else {
			  L = $1; 
			  move = " mv pdkt_kusuma_" i " kenangan/kenangan_" i ; }
				system(move); }' file.log 

for namafile in *.log; 
do 
	mv "$namafile" "${namafile%.log}.log.bak"
done 
