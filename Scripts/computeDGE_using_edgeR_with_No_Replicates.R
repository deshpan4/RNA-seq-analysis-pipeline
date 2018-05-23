library(edgeR)
counts<-read.csv("HTSeq-read-counts/sample-1-sample-2.txt",header=T,check.names=F)
l=apply(counts,1,function(y){all(y==0)})
f=counts[l,]
m=match(row.names(f),row.names(counts))
xx=counts[-m,]
group <- factor(c(1,2))
design <- model.matrix(~group)
y <- DGEList(counts=xx,group=group)
y1 <- calcNormFactors(y)
bcv <- 0.1
et1 <- exactTest(y1,dispersion = bcv^2)
et1new <- cbind(et1$table,p.adjust(et1$table$PValue,method="fdr"))
colnames(et1new) <- c("logFC","logCPM","PValue","FDR")
write.csv(et1new,quote=FALSE,row.names=FALSE,"Sample-1-Sample-2-significant-padj-lessthan-0.05-edgeR-results-with-No-replicates.csv")