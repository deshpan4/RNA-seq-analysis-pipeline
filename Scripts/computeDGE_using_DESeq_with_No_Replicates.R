library(DESeq)
s12<-read.csv("HTSeq-read-counts/sample-1-sample-2.txt",header=T,check.names=F)
condition=factor(c("untreated","treated"))
cds=newCountDataSet(s12,condition)
norm=estimateSizeFactors(cds)
disp=estimateDispersions(norm, method="blind", sharingMode="fit-only")
res=nbinomTest(disp,"untreated","treated")
resSig=res[res$padj<0.05,]
write.csv(resSig,quote=FALSE,row.names=FALSE,"Sample-1-Sample-2-significant-padj-lessthan-0.05-no-replicates-DESeq-results.csv")