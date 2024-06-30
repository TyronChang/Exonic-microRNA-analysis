#!/bin/bash

#change tsv file in to bed file
#human_all_genes_no_miR_df_TX_loc_NCBI.tsv is a file with transcription start and end coordinates instead of exon coordinates
awk -F '\t' '{print $0}' human_all_genes_no_miR_df_TX_loc_NCBI.tsv> human_all_genes_no_miR_df_TX_loc_NCBI.bed 

### This command will find all the intronic micrornas
bedtools intersect -a human_all_genes_no_miR_df_TX_loc_NCBI.bed -b human_nonoverlapmiR_NCBI.bed -s -wa -wb >human_intronic_miR_NCBI.bed
awk -F'\t' '{OFS="\t"; print $0}' human_intronic_miR_NCBI.bed>human_intronic_miR_NCBI.tsv

#this command will find the miRNAs without host  mRNAs
bedtools intersect -a human_nonoverlapmiR_NCBI.bed -b human_all_genes_no_miR_df_TX_loc_NCBI.bed -v >human_miR_no_hostmRNA_NCBI.bed

# this command convert final bed  fileis into tsv file
awk -F'\t' '{OFS="\t"; print $0}' human_miR_no_hostmRNA_NCBI.bed>human_miR_no_hostmRNA_NCBI.tsv

#Append the opposite stranded microRNAs onto the files with miRs that do not have host mRNA
awk -F'\t' '{OFS="\t"; print $1, $2, $3, $4, $5, $6, $7}' human_nonoverlapmiR_NCBI_opposite_strand_metadata.tsv>>human_miR_no_hostmRNA_NCBI.tsv

bedtools intersect -a human_all_genes_no_miR_df_TX_loc_NCBI.bed -b human_nonoverlapmiR_NCBI.bed -S -wa -wb >human_intronic_opposite_miR_NCBI.bed
awk -F'\t' '{OFS="\t"; print $0}' human_intronic_opposite_miR_NCBI.bed>human_intronic_opposite_miR_NCBI.tsv
awk -F'\t' '{OFS="\t"; print $9, $10, $11, $12, $13, $14, $15}' human_intronic_opposite_miR_NCBI.tsv>>human_miR_no_hostmRNA_NCBI.tsv

mv *.tsv Human_tsv_file
mv *.bed Human_bed_file
