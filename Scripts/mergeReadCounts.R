s1<-read.csv("HTSeq-read-counts/sample_$1_$2/file-1-2-read-counts.out",header=T,check.names=F)
s2<-read.csv("HTSeq-read-counts/sample_$4_$5/file-1-2-read-counts.out",header=T,check.names=F)
s12<-merge(s1,s2,by="GeneID",all.x=T)
write.csv(s12,quote=FALSE,row.names=FALSE,"HTSeq-read-counts/sample-1-sample-2.txt")