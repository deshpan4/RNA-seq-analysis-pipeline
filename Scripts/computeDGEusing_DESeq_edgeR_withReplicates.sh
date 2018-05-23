#!/bin/bash
PATH=$(pwd)
touch HTSeq-read-counts/sample_$1_$2/header.txt
echo -e "GeneID\tSample-1" > HTSeq-read-counts/sample_$1_$2/header.txt
touch HTSeq-read-counts/sample_$4_$5/header.txt
echo -e "GeneID\tSample-2" > HTSeq-read-counts/sample_$4_$5/header.txt
cat HTSeq-read-counts/sample_$1_$2/header.txt
Rscript mergeReadCounts.R
echo "Computing Differential Gene Expression using DESeq..."
Rscript computeDGE_using_DESeq_with_Replicates.R
echo "Computing Differential Gene Expression using edgeR..."
Rscript computeDGE_using_edgeR_with_Replicates.R