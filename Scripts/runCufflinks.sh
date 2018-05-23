#!/bin/bash
PATH=$(pwd)
NPROC=$3
echo "Transcript assembly using Cufflinks..."
mkdir sample_$1_$2/3-Cufflinks
$PATH/cufflinks-2.2.1.Linux_x86_64/cufflinks -I 5000 --min-intron-length 40 -G $PATH/Arabidopsis_thaliana/Ensembl/TAIR10/Annotation/Genes/genes.gtf -p NPROC -o sample_$1_$2/3-Cufflinks/file-1-2-cufflinks sample_$1_$2/2-Alignment/file-1-2-aligned-tophat2/accepted_hits.bam