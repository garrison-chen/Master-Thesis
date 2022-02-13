#!/bin/bash
counter=1
while read p
do
   grep -m 1 "LOCUS" $p > /Users/guangyichen/Desktop/Workflow/Preprocessing/length_/$counter.txt
   echo "Outputting the length of" $counter "th strain"
   (( counter++ ))
done < ${1}
