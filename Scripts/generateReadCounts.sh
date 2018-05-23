#!/bin/bash
PATH=$(pwd)
NPROC=$3
echo "Conversion of BAM file to SAM file..."
samtools index sample_$1_$2/2-Alignment/file-1-2-aligned-tophat2/accepted_hits.bam
samtools index sample_$4_$5/2-Alignment/file-1-2-aligned-tophat2/accepted_hits.bam
samtools view -h sample_$1_$2/2-Alignment/file-1-2-aligned-tophat2/accepted_hits.bam > sample_$1_$2/2-Alignment/file-1-2-aligned-tophat2/accepted_hits.sam
samtools view -h sample_$4_$5/2-Alignment/file-1-2-aligned-tophat2/accepted_hits.bam > sample_$1_$2/2-Alignment/file-1-2-aligned-tophat2/accepted_hits.sam
mkdir HTSeq-read-counts/sample_$1_$2
mkdir HTSeq-read-counts/sample_$4_$5
echo "Generate read counts using HTSeq..."
htseq-count sample_$1_$2/2-Alignment/file-1-2-aligned-tophat2/accepted_hits.sam $PATH/Arabidopsis_thaliana/Ensembl/TAIR10/Annotation/Genes/genes.gtf > HTSeq-read-counts/sample_$1_$2/file-1-2-read-counts.out
htseq-count sample_$4_$5/2-Alignment/file-1-2-aligned-tophat2/accepted_hits.sam $PATH/Arabidopsis_thaliana/Ensembl/TAIR10/Annotation/Genes/genes.gtf > HTSeq-read-counts/sample_$4_$5/file-1-2-read-counts.out