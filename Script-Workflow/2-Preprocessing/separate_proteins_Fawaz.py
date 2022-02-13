import os
import sys
import gzip
import pdb
from Bio import SeqIO


class Protein:
    def __init__(self, name, p_id, start, end, translation, parent_dir):
        self.name = name
        self.id = p_id
        self.start = start
        self.end = end
        self.translation = translation
        self.parent_dir = parent_dir

    def return_fasta(self):
        """
        generate FASTA sequence with a sequence name
        """
        if self.name == "":
            seq_name = ">" + "_".join([self.parent_dir, self.id, "coord:" + str(self.start), str(self.end)])
        else:
            seq_name = ">" + "_".join([self.parent_dir, self.name, self.id, "coord:" + str(self.start), str(self.end)])

        return seq_name + "\n" + self.translation + "\n"


def write_sequences(proteins, prot_name, out_file):
    """
    takes the proteins dict and the protein name
    outputs the sequences for that protein in the out_file in fasta format
    """
    with open(out_file, "w") as out_file:
        if prot_name in proteins:
            for prot in proteins[prot_name]:
                out_file.write(prot.return_fasta())


# check all gbf and gbff files in directory given
if len(sys.argv) < 3:
    print("You need to provide an input directory and an output directory")
in_dir = sys.argv[1]
out_dir = sys.argv[2]
gene_files = []
for f in os.listdir(in_dir):
    if f.endswith("gbf") or f.endswith("gbff") or f.endswith("gbff.gz") or f.endswith("gbf.gz"):
        gene_files.append(os.path.join(in_dir, f))

"""
I will loop through each file store the features and check if they are CDS
if so, then I take the qualifiers and take the "gene" key for the name
and the "translation" key for the amino acid sequence
I should keep this information for the name of the sequences
file name the sequence came from, gene name, location (start, end)

to get start and end, I take the feature.location.nofuzzy_start and nofuzzy_end
"""

proteins = dict()
for f in gene_files:
    # if gzipped then opening in text mode then giving the handle to seqio
    if f.endswith("gz"):
        handle = gzip.open(f, "rt")
    else:
        handle = open(f, "r")

    for rec in SeqIO.parse(handle, 'genbank'):
        for feature in rec.features:
            if feature.type == "CDS":

                # If the scrip was running from somewhere else, I take the name of the directory
                # where the genbank files are and use it as parent_dir
                # if the scrip was ran in the same directory the I get the current working directoy
                # and take the last part
                splits = f.split(os.sep)
                if (len(f.split(os.sep)) == 2) and (splits[0] == "."):
                    parent_dir = os.getcwd().split(os.sep)[-1]
                else:
                    parent_dir = f.split(os.sep)[-2]

                if "gene" not in feature.qualifiers:
                    if "translation" not in feature.qualifiers:
                        pass
                    else:
                        prot = Protein(name="", p_id=feature.qualifiers["protein_id"][0], 
                                        start=feature.location.nofuzzy_start, end=feature.location.nofuzzy_end,
                                        translation=feature.qualifiers["translation"][0], parent_dir=parent_dir)
                        if prot.id not in proteins:
                            proteins[prot.id] = [prot]
                        else:
                            proteins[prot.id].append(prot)
                else:
                    if "translation" not in feature.qualifiers:
                        pass
                    else:
                        prot = Protein(name=feature.qualifiers["gene"][0], p_id=feature.qualifiers["protein_id"][0], 
                                        start=feature.location.nofuzzy_start, end=feature.location.nofuzzy_end,
                                        translation=feature.qualifiers["translation"][0], parent_dir=parent_dir)
                        if prot.name not in proteins:
                            proteins[prot.name] = [prot]
                        else:
                            proteins[prot.name].append(prot)
            
print(proteins["WP_201423243.1"])

'''
for value in proteins.values():
	print(value)
'''

'''
for key, value in proteins.items():
	print(key)
	print(value)
	print("\n")
'''

'''
out_f_name = "example" + ".fasta"
with open(out_f_name, "w") as file:
	for protein in proteins:
		file.write(protein)

'''
'''
## TESTING, need to delete later
random_prots = ['fldA', 'rpoA', 'yoaE', 'ymgG', 'ydiK', 'ybeL', 'cdsA', 'yqhC', 'rsxG', 'arcB', 'alkA', 'ycaL']
for prot in random_prots:
    out_f_name = "e_coli_" + prot + ".fasta"
    with open(out_f_name, "w") as out_file:
        for protein in proteins[prot]:
            out_file.write(protein.return_fasta())
'''
# I might add a module that calls clustalo on each outputted protein to generate an MSA and maybe remove the original to save space
# $clustalo -i all_proteins.fasta -o all_proteins.aln --threads 10 --distmat-out=all_proteins.mat --force --full --percent-id
