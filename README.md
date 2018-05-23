# RNA-seq-analysis-pipeline
An RNA-seq pipeline for data processing and downstream analysis of Arabidopsis transcriptome sequencing datasets
## Getting Started
These instructions will help you to run the RNA-Seq pipeline from linux environment
The RNA-Seq pipeline performs the following tasks:
* File conversion from SRA to FastQ
* Perform quality metric using FastQC
* Adapter and Quality Trimming
* Read Alignment using Tophat2
* Read counting using HTSeq
* Differential Gene Expression using Cufflinks
* Differential Gene Expression using DESeq
* Differential Gene Expression using edgeR
* Alternative splicing analysis using spliceR
* Obtaining differentially expressed common genes between Cuffdiff, DESeq and edgeR in individual sample pairs
* Obtaining differentially expressed common genes between Cuffdiff, DESeq and edgeR expressed in more than one sample pairs
## Download
Use git clone:
```
git clone https://github.com/deshpan4/RNA-Seq-pipeline
```
## Installation
Download the RNA-Seq pipeline scripts using 'git clone' command. Make sure all the dependencies are installed before running the pipeline.
## Prerequisites
Following tools should be installed before executing this pipeline on the host system:
* samtools
* cufflinks version 2.2.1
* Tophat2 version 2.2.1
* FastQC
* cutadapt
* HTSeq
* Bowtie2
* [Index and annotation for A.thaliana](ftp://igenome:G3nom3s4u@ussd-ftp.illumina.com/Arabidopsis_thaliana/Ensembl/TAIR10/Arabidopsis_thaliana_Ensembl_TAIR10.tar.gz)
* [Blat](https://users.soe.ucsc.edu/~kent/src/blatSrc35.zip)
* R version 3.3 or higher
### R packages
* DESeq
* edgeR
* spliceR
* BSgenome
## Usage
**Step-1:** Run Data Processing pipeline
```
bash pipeline_Data_Processing.sh
```
**Step-2:** Transcript assembly
```
bash runCufflinks.sh
```
**Step-3:** Construct assembly file
For merging cufflinks assemblies, an assembly text file is required. For example, for samples [SRX765602](https://www.ncbi.nlm.nih.gov/sra/SRX765602[accn]) and [SRX765948](https://www.ncbi.nlm.nih.gov/sra/SRX765948[accn]), no replicates are available. Therefore, write the following information to text file using notepad or text editor.
```
/sample_SRR1659921_SRR1659922/3-Cufflinks/file-1-2-cufflinks/transcripts.gtf
/sample_SRR1660397_SRR1660398/3-Cufflinks/file-1-2-cufflinks/transcripts.gtf
```
For example, for [SRX765602](https://www.ncbi.nlm.nih.gov/sra/SRX765602[accn]), [SRX1068195](https://www.ncbi.nlm.nih.gov/sra/SRX1068195[accn]) and [SRX767119](https://www.ncbi.nlm.nih.gov/sra/SRX767119[accn]), where there are replicates available. Therefore, write the following information to text file using notepad or text editor.
```
/home/sample_SRR1659921_SRR1659922/3-Cufflinks/file-1-2-cufflinks/transcripts.gtf
/home/sample_SRR2073174_SRR2073176/3-Cufflinks/file-1-2-cufflinks/transcripts.gtf
/home/sample_SRR1661473_SRR1661474/3-Cufflinks/file-1-2-cufflinks/transcripts.gtf
```
**Step-4:** Compute Differential Gene Expression using Cuffdiff
```
bash computeDGEusingCuffdiff.sh
```
**Step-5:** Generate read counts using HTSeq
```
bash generateReadCounts.sh
```
**Step-6:** If the samples have biological replicates, then run the following script
```
bash computeDGEusing_DESeq_edgeR_withReplicates.sh
```
If the samples do not have biological replicates, then run the following script
```
bash computeDGEusing_DESeq_edgeR_noReplicates.sh
```
**Step-7:** Construct BSgenome package for A.thaliana TAIR10 data
However, there is already BSgenome package availabe in CRAN 'BSgenome.Athaliana.TAIR.TAIR9', but we recommend users to construct TAIR10 version of BSgenome. The FASTA genome file has already been converted to 2bit format (athalianaTAIR10.2bit) and is available in the "Genome" folder. However, if the user would like to convert the FASTA file to 2bit himself, "faToTwoBit" tool is required.
```
faToTwoBit genome.fa athalianaTAIR10.2bit
```

Set the 'seqs_srcdir:' in 'BSgenome.Athaliana.TAIR.TAIR10-seed' file (which is available in Genome folder) by adding the path to wherever the athalianaTAIR10.2bit file is located.

In R run the following command:

```
setwd("/path/to/seed/file")
library(BSgenome)
forgeBSgenomeDataPkg(BSgenome.Athaliana.TAIR.TAIR10-seed)
```

This command will generate a folder which can be used to install the package on the system.

Next, in command-line, run the following command:

```
R CMD build BSgenome.Athaliana10.TAIR.TAIR10
R CMD INSTALL BSgenome.Athaliana10.TAIR.TAIR10_1.4.2.tar.gz
```
**Step-8:** Alternative splicing analysis using spliceR
```
Rscript spliceR_analysis.R
```
NOTE: User must specify required path of cuffdiff output folder in 'spliceR_analysis.R' file.

**Step-9:** Merging differentially expressed Gene IDs in more than one sample pairs

In order to merge DE gene IDs, user must first extract At gene IDs from GTF file (merged.gtf) merged by Cuffmerge for the sample pair under comparison. For example, if the user would like to extract Gene IDs present in more than 1 sample pair in 5 samples i.e. S1, S2, S3, S4, S5 and the comparison is against the first sample S1 such as (S1 vs S2, S1 vs S3, S1 vs S4 and S1 vs S5), then those genes will be extracted which are expressed in more than one sample pairs. First step is to extract At IDs from GTF file as DGE table obtained from Cuffdiff (gene_exp.diff) file contains gene names instead of gene IDs. To extract the gene IDs run the following script.
```
bash extractGeneID_from_GTF.sh
Rscript mergeGeneID_with_Cuffdiff_res.R cuffdiff_file DESeq_file edgeR_file geneid_genename.txt
```
Merge DGE genes from Cuffdiff (C), DESeq (D) and edgeR (E) in individual sample pairs. For example, to merge C, D, E genes in S1 vs S2 sample pair (Sample-1-2), run the following script.
```
Rscript merge_CDE.R cuffdiff_file DESeq_file edgeR_file
```
In each of the sample pair files, append sample name to each cuffdiff, DESeq and edgeR result files in R. For example, for sample pair S1 vs S2 (Sample-1-2-common-genes-C-D-E.csv)
```
## In R
df<-read.csv("Sample-1-2-common-genes-C-D-E.csv",header=T,check.names=F)
e1<-"S1S2"
df["Sample1_Sample2"]<-e1
df1<-df[,c("id","Sample1_Sample2")]
write.csv(df,quote=FALSE,row.names=FALSE,"Sample-1-2-common-genes-C-D-E.csv")
write.csv(df1,quote=FALSE,row.names=FALSE,"Sample-1-2-common-genes-C-D-E-idname.csv")
```
First merge multiple sample pair files:
```
s12<-read.csv("Sample-1-2-common-genes-C-D-E-idname.csv",header=T,check.names=F)
s13<-read.csv("Sample-1-3-common-genes-C-D-E-idname.csv",header=T,check.names=F)
s14<-read.csv("Sample-1-4-common-genes-C-D-E-idname.csv",header=T,check.names=F)
s15<-read.csv("Sample-1-5-common-genes-C-D-E-idname.csv",header=T,check.names=F)
s123<-merge(s12,s13,by="id",all.x=T)
s1234<-merge(s123,s14,by="id",all.x=T)
s12345<-merge(s1234,s15,by="id",all.x=T)
write.csv(s12345,quote=FALSE,row.names=FALSE,"Sample-1-2-3-4-5-common-genes-C-D-E-idname.csv")
```
Extract common genes present in more than one column from multiple sample pairs.
```
Rscript extract_common_genes.R Sample-1-2-3-4-5-common-genes-C-D-E-idname.csv
```
