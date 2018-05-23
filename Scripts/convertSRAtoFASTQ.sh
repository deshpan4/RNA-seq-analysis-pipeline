#!/bin/bash
PATH=$(pwd)
$PATH/sratoolkit.2.5.4-1-centos_linux64/bin/fastq-dump $1.sra > $1.fastq
$PATH/sratoolkit.2.5.4-1-centos_linux64/bin/fastq-dump $2.sra > $2.fastq
mkdir temp
cp $1.fastq
cp $2.fastq
mv temp/$1.fastq temp/file-1.fastq
mv temp/$2.fastq temp/file-2.fastq