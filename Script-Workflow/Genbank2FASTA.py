import sys, os
from Bio import SeqIO

gbk_filename = sys.argv[1]
root_name = os.path.splitext(gbk_filename)[0]
fasta_filename = root_name + "_converted.fasta"

input_handle  = open(gbk_filename, "r")
output_handle = open(fasta_filename, "w")

#genome_record = SeqIO.read(input_handle, "genbank")
protein_seq = ""

for seq_record in SeqIO.parse(input_handle, "genbank"):
    for feature in seq_record.features:
        if feature.type == "CDS" and str(feature.qualifiers.get('translation')) != "None":
            if str(feature.qualifiers.get('protein_id')) != "None":
                protein_seq += ">" + str(feature.qualifiers.get('protein_id')) + "\n" + str(feature.qualifiers.get('translation')) + "\n"
            else:
                protein_seq += ">" + str(feature.qualifiers.get('locus_tag')) + "\n" + str(feature.qualifiers.get('translation')) + "\n"
    break

protein_seq = protein_seq.replace("['","").replace("']","")

output_handle.write(protein_seq)

output_handle.close()
input_handle.close()
#print(protein_seq)
#print("-----------------------------------------")
print("Done :)")
