#!/bin/bash
# Calling: bash download.sh accession-id-list.txt

COUNTER=1
while read p
do
   efetch -db nuccore -id $p -format gb > ${2}/$p.gb
   sleep 2
   #efetch -db nuccore -id $p -format fasta_cds_aa > ${2}/$p.fasta
   echo "downloading the" $COUNTER "th strain"
   (( COUNTER++ ))
   sleep 2
done < ${1}

