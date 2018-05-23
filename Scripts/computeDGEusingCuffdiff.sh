#!/bin/bash
PATH=$(pwd)
NPROC=$3
echo "Merge Cufflinks assemblies using Cuffmerge..."
mkdir 4-Cuffmerge
cd 4-Cuffmerge
$PATH/cufflinks-2.2.1.Linux_x86_64/cuffmerge -g $PATH/Arabidopsis_thaliana/Ensembl/TAIR10/Annotation/Genes/genes.gtf -s $PATH/Arabidopsis_thaliana/Ensembl/TAIR10/Sequence/WholeGenomeFasta/genome.fa -p 6 ../assembly-1-2.txt
cd ..
echo "Differential Gene Expression using Cuffdiff from two samples..."
mkdir 5-Cuffdiff
$PATH/cufflinks-2.2.1.Linux_x86_64/cuffdiff -o diff_out_quartile_sample_7_sample_9 -b $PATH/Arabidopsis_thaliana/Ensembl/TAIR10/Sequence/WholeGenomeFasta/genome.fa -p NPROC -L sample_$1_$2,sample_$4_$5 -u sample_$1_$2/4-Cuffmerge/merged_asm/merged.gtf sample_$1_$2/2-Alignment/file-1-2-aligned-tophat2/accepted_hits.bam sample_$4_$5/2-Alignment/file-1-2-aligned-tophat2/accepted_hits.bam --library-norm-method quartile --multi-read-correct