##               Mining exonic miRNAs from human and mouse genome


This script is written by Tyron Chang , the programming languages and tools used for this study are are shown below:
1. Python (data cleaning and processing)
2. BEDTools (overlapping the exonic microRNAs)
3. Shell (use awk and basic command lines to convert tsv files into bed file)



![Model](./pipeline.png)

### The pipeline is shown above 

All the data cleaning is carried out with shell and python.

Data cleaning is done with python file. Here I use OOP to import a series of classes and methods:

Data.ipynb ->this file is for data cleaning

Gene_func.ipynb-> this file will assign new column to the dataframe to indicate if the host gene is a protein coding or non-coding gene.

Subsequent characterization of exon-derived miRNAs (GO analysis, heatmap, etc) was carried out with the metadata generated from this pipeline


