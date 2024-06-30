#!/bin/bash
#### This script will move the UCSC data into the folder called UCSC_data_Human
#### Run this shell script after all the analysis is done.
mkdir UCSC_data_Human
mkdir Human_csv_file

mv human_genes_010324_NCBI.csv UCSC_data_Human
mv *.csv Human_csv_file 
