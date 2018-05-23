#!/bin/bash
PATH=$(pwd)
NPROC=$3
echo "Converting samples in SRA to FASTQ format..."
$PATH/sratoolkit.2.5.4-1-centos_linux64/bin/fastq-dump $1.sra > $1.fastq
$PATH/sratoolkit.2.5.4-1-centos_linux64/bin/fastq-dump $2.sra > $2.fastq
mkdir sample_$1_$2
cp $1.fastq
cp $2.fastq
mv sample_$1_$2/$1.fastq sample_$1_$2/file-1.fastq
mv sample_$1_$2/$2.fastq sample_$1_$2/file-2.fastq
echo "Quality metrics evaluation using FastQC..."
$PATH/FastQC/fastqc sample_$1_$2/file-1.fastq
$PATH/FastQC/fastqc sample_$1_$2/file-2.fastq
mkdir sample_$1_$2/1-Adapter-Quality-Trimming
echo "Performing Adapter and Quality Trimming..."
$PATH/cutadapt-1.8.3/bin/cutadapt -u 15 -o sample_$1_$2/1-Adapter-Quality-Trimming/file-1-trimmed.fastq sample_$1_$2/file-1.fastq
$PATH/cutadapt-1.8.3/bin/cutadapt -u 15 -o sample_$1_$2/1-Adapter-Quality-Trimming/file-2-trimmed.fastq sample_$1_$2/file-2.fastq
echo "Reference genome alignment using Tophat2..."
mkdir sample_$1_$2/2-Alignment
$PATH/tophat-2.1.0.Linux_x86_64/tophat2 -p NPROC --max-multihits 1 -i 40 -I 5000 --library-type fr-unstranded --b2-very-sensitive --segment-length 20 --segment-mismatches 2 -F 0 -g 1 -a 10 -G $PATH/Arabidopsis_thaliana/Ensembl/TAIR10/Annotation/Genes/genes.gtf -o sample_$1_$2/2-Alignment/file-1-2-aligned-tophat2 $PATH/Arabidopsis_thaliana/Ensembl/TAIR10/Sequence/Bowtie2Index/genome sample_$1_$2/1-Adapter-Quality-Trimming/file-1-trimmed.fastq sample_$1_$2/1-Adapter-Quality-Trimming/file-2-trimmed.fastq