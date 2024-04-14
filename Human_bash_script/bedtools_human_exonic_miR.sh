#!/bin/bash

#This shell script is written by Tyron Chang
#This shell script will overlap all exonic miRs that are completely contained within exons 
#==================================================

#convert gff file from miRbase into tsv file first 
awk -F'\t' 'BEGIN{OFS="\t"} $1 ~ /^#/ {next} {gsub(";", "\t", $9); print $1, $3, $4, $5, $7, $9}' hsa.gff > hsa.tsv
#================================================
#This command convert tsv fileis into bed file
#files without microRNA

awk -F'\t' '{OFS="\t"; print $1, $2, $3, $4, $5, $6, $7, $8}' human_all_genes_no_miR_df_NCBI.tsv > human_all_genes_no_miR_df_NCBI.bed 


#files with microRNA and convert it into bed file
awk -F'\t' '{OFS="\t"; print $1, $3, $4, $2, $8, $5, $7}' hsa.tsv > hsa.bed

####alternatively, you can also use a different miR data derived from NCBI refseq
#awk -F'\t' '{OFS="\t"; print $1, $2, $3, $4, $5, $6, $7, $8}' df_humanmiR_NCBI.tsv > df_human_miR_NCBI.bed

#===============================================
#Using bedtools to overlap exonic microRNAs and export it as tsv file
#-F 1 flag means 100% overlap of miR to the exon, -s means on the same strand

bedtools intersect -a human_all_genes_no_miR_df_NCBI.bed  -b hsa.bed -s -wa -wb -F 1 >human_exonic_miR_NCBI.bed 

# this command convert final bed  fileis into tsv file
awk -F'\t' '{OFS="\t"; print $0}' human_exonic_miR_NCBI.bed>human_exonic_miR_NCBI.tsv
