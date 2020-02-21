#!/bin/bash

awk -F "," 'NR > 1 {r[$13]+=$21} END 
	{for i'Sample-Superstore.tsv | sort -g | head -1
