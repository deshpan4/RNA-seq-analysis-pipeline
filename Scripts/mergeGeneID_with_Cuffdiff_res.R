#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
sC<-read.csv(args[1],header=T,check.names=F)
sD<-read.csv(args[2],header=T,check.names=F)
sE<-read.csv(args[3],header=T,check.names=F)
geneidname<-read.csv(args[4],header=T,check.names=F)
a1<-sC[which(sC$q_value <= 0.05),]
a2<-sD[which(sD$padj <= 0.05),]
a3<-sE[which(sE$FDR<= 0.05),]
a1g<-merge(a1,geneidname,by="gene",all.x=T)
write.csv(a1g,quote=FALSE,row.names=FALSE,"Sample-1-Sample-2-significant-padj-lessthan-0.05-Cuffdiff-results.csv")
write.csv(a2,quote=FALSE,row.names=FALSE,"Sample-1-Sample-2-significant-padj-lessthan-0.05-DESeq-results.csv")
write.csv(a3,quote=FALSE,row.names=FALSE,"Sample-1-Sample-2-significant-padj-lessthan-0.05-edgeR-results.csv")