#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
sC<-read.csv(args[1],header=T,check.names=F)
sD<-read.csv(args[2],header=T,check.names=F)
sE<-read.csv(args[3],header=T,check.names=F)
sCD<-merge(sC,sD,by="id",all.x=T)
sCDE<-merge(sCD,sE,by="id",all.x=T)
write.csv(sCDE,quote=FALSE,row.names=FALSE,"Sample-1-2-common-genes-Cuffdiff-DESeq-edgeR.csv")