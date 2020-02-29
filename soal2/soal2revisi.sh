#!/bin/bash
 
if [[ $1 =~ ^[a-zA-Z]+$ ]]
then
	dd if=/dev/urandom|tr -dc 'A-Z'|head -c 1 >> $1.txt
	dd if=/dev/urandom|tr -dc 'a-z'|head -c 1 >> $1.txt
	dd if=/dev/urandom|tr -dc '0-9'|head -c 1 >> $1.txt
	
else
	echo "error"
fi
