#!/bin/bash

awk -F '\t' '{print $0}' mouse_all_genes_no_miR_df_TX_loc_NCBI.tsv> mouse_all_genes_no_miR_df_TX_loc_NCBI.bed 

### This command will find all the intronic micrornas
bedtools intersect -a mouse_all_genes_no_miR_df_TX_loc_NCBI.bed -b mouse_nonoverlapmiR_NCBI.bed -s -wa -wb >mouse_intronic_miR_NCBI.bed
awk -F'\t' '{OFS="\t"; print $0}' mouse_intronic_miR_NCBI.bed>mouse_intronic_miR_NCBI.tsv

#this command will find the miRNAs without host  mRNAs
bedtools intersect -a mouse_nonoverlapmiR_NCBI.bed -b mouse_all_genes_no_miR_df_TX_loc_NCBI.bed -v >mouse_miR_no_hostmRNA_NCBI.bed

# this command convert final bed  fileis into tsv file
awk -F'\t' '{OFS="\t"; print $0}' mouse_miR_no_hostmRNA_NCBI.bed>mouse_miR_no_hostmRNA_NCBI.tsv

#Append the opposite stranded microRNAs onto the files with miRs that do not have host mRNA
awk -F'\t' '{OFS="\t"; print $1, $2, $3, $4, $5, $6, $7}' mouse_nonoverlapmiR_NCBI_opposite_strand_metadata.tsv>>mouse_miR_no_hostmRNA_NCBI.tsv

bedtools intersect -a mouse_all_genes_no_miR_df_TX_loc_NCBI.bed -b mouse_nonoverlapmiR_NCBI.bed -S -wa -wb >mouse_intronic_opposite_miR_NCBI.bed
awk -F'\t' '{OFS="\t"; print $0}' mouse_intronic_opposite_miR_NCBI.bed>mouse_intronic_opposite_miR_NCBI.tsv
awk -F'\t' '{OFS="\t"; print $9, $10, $11, $12, $13, $14, $15}' mouse_intronic_opposite_miR_NCBI.tsv>>mouse_miR_no_hostmRNA_NCBI.tsv


