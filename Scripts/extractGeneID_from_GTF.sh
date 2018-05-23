#!/bin/bash
cut -f9 merged.gtf > col-9.txt
cut -d';' -f4 col-9.txt > genename.txt
cut -d';' -f5 col-9.txt > geneid1.txt
sed 's/gene_name //g' genename.txt > genename1.txt
sed 's/"//g' genename1.txt > genename2.txt
sed -i '1s/^/gene/' genename2.txt > genename3.txt
sed 's/oId //g' geneid1.txt > geneid2.txt
sed 's/"//g' geneid2.txt > geneid3.txt
sed -i '1s/^/id/' geneid3.txt > geneid4.txt
paste -d',' genename3.txt geneid4.txt > geneid_genename.txt