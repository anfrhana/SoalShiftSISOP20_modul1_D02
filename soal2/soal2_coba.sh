#!/bin/bash

lower=abcdefghijklmnopqrstuvwxyz
lower=$lower$lower
upper=ABCDEFGHIJKLMNOPQRSTUVWXYZ
upper=$upper$upper

name=$(echo "$1" | tr -d '.txt')
jam=$(date +"%k")
rename=$(echo $name | tr "${upper:0:26}${lower:0:26}" "${upper:$jam:26}${lower:$jam:26}")

mv $1 $rename.txt
