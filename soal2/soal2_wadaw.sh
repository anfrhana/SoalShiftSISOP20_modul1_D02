#!/bin/bash

lower=abcdefghijklmnopqrstuvwxyz
lower=$lower$lower
upper=ABCDEFGHIJKLMNOPQRSTUVWXYZ
upper=$upper$upper

name=$(echo "$1" | tr -d '.txt')
#jam=$(date +"%k")
time=$(stat -c %y $1 | grep -oP '(?<=[^ ] ).*(?=:.*:)')
echo "$time"
rename=$(echo $name | tr "${upper:$time:26}${lower:$time:26}" "${upper:0:26}${lower:0:26}")

mv $1 $rename.txt
