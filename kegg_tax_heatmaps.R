library(tidyr)       
library(ggplot2)     
library(gridExtra)   
library(ggthemes) 
library(viridis)   

# Read data and format for heatmap
dataA <- read.csv(file="kegg_taxA.tsv",header=TRUE,sep="\t")
dataA.long <- gather(dataA, key = KO, value = KO_abund, -c(1:2))

heatmapA <- ggplot(dataA.long, mapping = aes(x = Taxon, y = KO, fill = KO_abund),fill = "transparent") +
geom_tile() +
facet_grid(. ~ Sample) + facet_wrap(. ~ Sample,ncol=1) +
scale_fill_viridis(option="magma", direction=-1, limits=c(0, 0.025)) +
theme(axis.text.y = element_text(size = 10, color="black"), 
axis.text.x = element_text(angle=90, hjust=1, size =4, color="black"), 
axis.title.x =element_text(size=10, color="black"), 
axis.title.y =element_text(size=10, color ="black"),
panel.background = element_rect(fill = "transparent"),
plot.background = element_rect(fill = "transparent"), 
panel.grid.major = element_blank(),
panel.grid.minor = element_blank())

# Read data and format for heatmap
dataB <- read.csv(file="kegg_taxB.tsv",header=TRUE,sep="\t")
dataB.long <- gather(dataB, key = KO, value = KO_abund, -c(1:2))

heatmapB <- ggplot(dataB.long, mapping = aes(x = Taxon, y = KO, fill = KO_abund),fill = "transparent") +
geom_tile() +
facet_grid(. ~ Sample) + facet_wrap(. ~ Sample,ncol=1) +
scale_fill_viridis(option="magma", direction=-1, limits=c(0, 0.025)) +
theme(axis.text.y = element_text(size = 10, color="black"), 
axis.text.x = element_text(angle=90, hjust=1, size =4, color="black"), 
axis.title.x =element_text(size=10, color="black"), 
axis.title.y =element_text(size=10, color ="black"),
panel.background = element_rect(fill = "transparent"),
plot.background = element_rect(fill = "transparent"), 
panel.grid.major = element_blank(),
panel.grid.minor = element_blank())

# Read data and format for heatmap
data_all <- read.csv(file="kegg_tax.tsv",header=TRUE,sep="\t")
data_all.long <- gather(data_all, key = KO, value = KO_abund, -c(1:2))

heatmap_all <- ggplot(data_all.long, mapping = aes(x = Taxon, y = KO, fill = KO_abund),fill = "transparent") +
geom_tile() +
facet_grid(. ~ Sample) + facet_wrap(. ~ Sample,ncol=1) +
scale_fill_viridis(option="magma", direction=-1, limits=c(0, 0.025)) +
theme(axis.text.y = element_text(size = 10, color="black"), 
axis.text.x = element_text(angle=90, hjust=1, size =4, color="black"), 
axis.title.x =element_text(size=10, color="black"), 
axis.title.y =element_text(size=10, color ="black"),
panel.background = element_rect(fill = "transparent"),
plot.background = element_rect(fill = "transparent"), 
panel.grid.major = element_blank(),
panel.grid.minor = element_blank())