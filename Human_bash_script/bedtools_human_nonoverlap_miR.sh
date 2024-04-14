#!/bin/bash

#==========
#Using bedtools to find nonexonic microRNAs with and export it as tsv file
#-v means find all the nonoverlapped regions -F 1 flag means 100% overlap of miR to the exon, -s means on the same strand
# This command will find all the nonexonic microRNAs (intronic and nonhostgene ones)

bedtools intersect -a hsa.bed -b human_all_genes_no_miR_df_NCBI.bed -v >human_nonoverlapmiR_NCBI.bed 

#this command will find the ones opposite to the host mRNAs
bedtools intersect -a human_all_genes_no_miR_df_NCBI.bed -b hsa.bed -wa -wb -S >human_nonoverlapmiR_NCBI_opposite_strand_metadata.bed 

# this command convert final bed  fileis into tsv file
awk -F'\t' '{OFS="\t"; print $0}' human_nonoverlapmiR_NCBI.bed>human_nonoverlapmiR_NCBI.tsv
awk -F'\t' '{OFS="\t"; print $9, $10, $11, $12, $13, $14,$15}' human_nonoverlapmiR_NCBI_opposite_strand_metadata.bed>human_nonoverlapmiR_NCBI_opposite_strand_metadata.tsv

#Append the opposite stranded microRNAs onto the original files
awk -F'\t' '{OFS="\t"; print $9, $10, $11, $12, $13, $14, $15}' human_nonoverlapmiR_NCBI_opposite_strand_metadata.tsv>>human_nonoverlapmiR_NCBI.tsv

#### This step is to regoranize columns in hsa.tsv file for python to read 
awk -F'\t' '{OFS="\t"; print $1, $3, $4, $2, $8, $5, $7}' hsa.tsv > hsa_finalized.tsv
