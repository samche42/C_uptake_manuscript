library(pheatmap)

#Read in count data
data = read.csv("nonzerocats.txt", header= TRUE, sep="\t", row.names =1)

#Convert data to matrix
df_num = as.matrix(data)

#Read in gene info
gene_info = read.csv("geneinfo.txt", header= TRUE, sep="\t", row.names =1)

#Add in categorical info
fig <- pheatmap(df_num, annotation_row = gene_info, cluster_rows = FALSE, cluster_cols = FALSE, cutree_cols = 1,legend = TRUE, fontsize = 3, color=hcl.colors(50, "BuPu", rev=TRUE))
