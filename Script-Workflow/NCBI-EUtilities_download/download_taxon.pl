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
        open(IDS, "tmpids") or die $!;
        while(<IDS>){
                if(m/^\s+<Id>/){
                        $id = (m/<Id>(\d+)<\/Id>/)[0];
                        print $id."\n";
                        system("curl 'https://eutils.ncbi.nlm.nih.gov/entrez/eut
ils/efetch.fcgi?db=nuccore&id=".$id."&rettype=fasta' >tmpseq");
#print "curl 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nucco
re&id=".$id."&rettype=fasta' >tmpseq";
                        my $seqid;
#system("cat tmpseq");
                        open(SEQ, "tmpseq") or die $!;
                        while(my $l = <SEQ>){
#print $l;
                                if($l =~ m/^>/){
                                        $seqid = (split(/\./, (split(/\s+/, $l))
[0]))[0];
                                        $seqid =~ s/^>//;
#print $l.$seqid;
                                        last;
                                }
                        }
                        close(SEQ);
                        if(defined $seqid){ system("cp tmpseq ".$seqid.".fasta")
; }
#exit(0);
                }
        }
        close(IDS);
        system("rm tmpids");
}
