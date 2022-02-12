#!/bin/bash

# for strain in Archangium Cystobacter Hyalangium Melittangium Stigmatella Vitiosangium Aggregicoccus Corallococcus Myxococcus myxococcales Pyxidicoccus Simulacricoccus Vulgatibacter Nannocystineae Kofleriaceae Haliangium Kofleria Nannocystaceae Nannocystis Plesiocystis Pseudenhygromyxa Sorangiineae Labilitrichaceae Labilithrix Phaselicystidaceae Phaselicystis Polyangiaceae Aetherobacter Byssovorax Chondromyces Jahnella Pajaroellobacter Polyangium Racemicystis Sorangium Sandaracinaceae Sandaracinus Minicystis Enhygromyxa Enhygromyxa salina;do bash download_assemblies.sh $strain assembly_summary.txt;done

if [[ $# -lt "2" ]];then
        echo "Too few arguments, you need to give some strain name and the location of the assembly summary txt file"
        exit 1
fi

strain=$1
info_file=$2


# the assembly_summary.txt was downloaded from this link
# ftp://ftp.ncbi.nlm.nih.gov/genomes/README_assembly_summary.txt
# it contains information and links to assemblies
if [ -f "$info_file" ]; then
 __
#!/bin/bash

# for strain in Archangium Cystobacter Hyalangium Melittangium Stigmatella Vitiosangium Aggregicoccus Corallococcus Myxococcus myxococcales Pyxidicoccus Simulacriangium Aggregicoccus Corallococcus Myxococcus myxococcales Pyxidicoccus Simulacri
#!/bin/bash

# for strain in Archangium Cystobacter Hyalangium Melittangium Stigmatella Vitios
angium Aggregicoccus Corallococcus Myxococcus myxococcales Pyxidicoccus Simulacri
coccus Vulgatibacter Nannocystineae Kofleriaceae Haliangium Kofleria Nannocystaceae Nannocystis Plesiocystis Pseudenhygromyxa Sorangiineae Labilitrichaceae Labilithrix Phaselicystidaceae Phaselicystis Polyangiaceae Aetherobacter Byssovorax Chondromyces Jahnella Pajaroellobacter Polyangium Racemicystis Sorangium Sandaracinaceae Sandaracinus Minicystis Enhygromyxa Enhygromyxa salina;do bash download_assemblies.sh $strain assembly_summary.txt;done

if [[ $# -lt "2" ]];then
        echo "Too few arguments, you need to give some strain name and the location of the assembly summary txt file"
        exit 1
fi

strain=$1
info_file=$2


# the assembly_summary.txt was downloaded from this link
# ftp://ftp.ncbi.nlm.nih.gov/genomes/README_assembly_summary.txt
# it contains information and links to assemblies
if [ -f "$info_file" ]; then
        mkdir $strain
        # this assembly_info might have repeated lines because of the different
        # assembly summary files, it will get filtered later
        grep -i $strain $info_file >> $strain/assembly_info.txt
        # finding the download link that starts with ftp
        cat $strain/assembly_info.txt | awk '{for (i=1; i<=NF;i++){if ($i ~ /^ftp/){print $i}}}' > $strain/list_of_links.txt
else
        # wget ftp://ftp.ncbi.nlm.nih.gov/genomes/ASSEMBLY_REPORTS/assembly_summary_genbank.txt
        # user should download it himself I guess
        echo "The summary file ($info_file) you gave does not exist"
        echo "Download one like assembly_summary.txt, assembly_summary_genbank.txt, or assembly_summary_refseq.txt"
        exit 1
fi

while read -r ftp_line; do

        dir="${ftp_line%/*}"
        sample="${ftp_line##*/}"
        assembly_link=$dir/$sample/$sample\_genomic.fna.gz
        assembly_file=$strain/$sample\_genomic.fna.gz
        # echo $assembly_file
        if [ ! -f "$assembly_file" ];then
                echo "downloading assembly $assembly_file"
                echo $assembly_link | xargs wget --no-clobber -P $strain
                grep $sample $strain/assembly_info.txt >> all_downloaded_assembly
_info.txt
                grep $sample $strain/assembly_info.txt >> $strain/tmp.txt
                echo $assembly_file >> $strain/summary.txt
                gzip -cd $assembly_file | grep ">" | wc -l >> $strain/summary.txt
        fi
        mv $strain/tmp $strain/assembly_info.txt
done < $strain/list_of_links.txt


# for assem in $strain/*.gz
# do
#       echo $assem >> $strain/summary.txt
#       gzip -cd $assem | grep ">" | wc -l >> $strain/summary.txt
# done
