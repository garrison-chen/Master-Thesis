#!/usr/bin/perl
use warnings;
use strict;

my $count;
#!/usr/bin/perl
use warnings;
use strict;

my $count;
#system("curl --connect-timeout 120 'https:\/\/eutils.ncbi.nlm.nih.gov\/entrez\/eutils\/efetch.fcgi?db=nuccore\&id=".(split)[0]."\&rettype=fasta' >tmp_genome.fasta");
system("curl --connect-timeout 120 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=nuccore&term=txid".$ARGV[0]."\\[Organism:exp\\]&usehistory=y&rettype=count' >tmpcount");
open(C, "tmpcount") or die $!;
while(<C>){
        if(m/^\s+<Count>/){
                $count = (m/<Count>(\d+)<\/Count>/)[0];
                last;
        }
}
close(C);
system("rm tmpcount");

print $count."\n";
for(my $ii = 0; $ii < $count / 100000; $ii++){
        if($ii == 0){
                system("curl --connect-timeout 120 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=nuccore&term=txid".$ARGV[0]."\\[Organism\\]&usehistory=y&retmax=100000' >tmpids");
        }else{
                system("curl --connect-timeout 120 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=nuccore&term=txid".$ARGV[0]."\\[Organism\\]&usehistory=y&retmax=100000&retstart=".($ii * 100000 + 1)."' >tmpids");
        }
        my $id;
Last login: Sun Oct 24 12:27:56 on ttys000
import xml.etree.ElementTree as ET
import sys
import subprocess
import os
import time

fw = open(sys.argv[3], "w")
f = open(sys.argv[1], "r")
for n in f:
    n = n.rstrip('\n')
    n = n.rstrip('\t')
    n = n.rstrip('\r')
    print(n)
    id = ""
    command0 = "curl 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=nuccore&term=" + n + "&retmode=xml' >" + sys.argv[2] + "tmp.xml"
    os.system(command0)
    try:
        root = ET.parse(sys.argv[2] + "tmp.xml").getroot()
    except ET.ParseError:
        print("XML Error 1: n");
    for child in root:
        if child.tag == 'IdList':
            for child2 in child:
                id = child2.text

    time.sleep(0.3)
    command = "curl 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nuccore&id=" + id + "&retmode=xml' >" + sys.argv[2] + "tmp.xml"
    os.system(command)
    time.sleep(0.3)
    try:
        root = ET.parse(sys.argv[2] + "tmp.xml").getroot()
    except ET.ParseError:
        print("XML Error 2: id");
    for child in root:
        for child2 in child:
            if child2.tag == 'GBSeq_alt-seq':
                for child3 in child2:
                    for child4 in child3:
                        if child4.tag == 'GBAltSeqData_items':
                            first_acc = last_acc = ''
                            for child5 in child4:
                                for child6 in child5:
                                    if child6.tag == 'GBAltSeqItem_first-accn':
                                        first_acc = child6.text
                                    if child6.tag == 'GBAltSeqItem_last-accn':
                                        last_acc = child6.text
                            fw.write(n + "\t" + first_acc + "\t" + last_acc + "\
n")
fw.close()
f.close()
