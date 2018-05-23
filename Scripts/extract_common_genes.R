#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
a<-read.csv(args[1],header=T,check.names=F)
r1<-rowSums(is.na(a))
a["count"]<-r1
a1<-a[which(a$count != 5),]
a2<-a1[which(a1$count != 4),]