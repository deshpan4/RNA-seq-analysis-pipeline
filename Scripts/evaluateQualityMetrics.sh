#!/bin/bash
PATH=$(pwd)
$PATH/FastQC/fastqc $1.fastq
$PATH/FastQC/fastqc $2.fastq