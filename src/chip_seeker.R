
source("lib.R")

#BiocManager::install("org.Hs.eg.db")

library(ChIPseeker)
library(clusterProfiler)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
library(org.Hs.eg.db)

txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene

name_1 <- 'H3K4me1_HCT116_ENCFF699ABD_hg19_filtered.bed'
name_2 <- 'H3K4me1_HCT116_ENCFF931YSQ_hg19_filtered.bed'

bed_1 <- paste0(DATA_DIR, name_1)
bed_2 <- paste0(DATA_DIR, name_2)

peakAnno_1 <- annotatePeak(bed_1, tssRegion=c(-3000, 3000), TxDb=txdb, annoDb="org.Hs.eg.db")
peakAnno_2 <- annotatePeak(bed_2, tssRegion=c(-3000, 3000), TxDb=txdb, annoDb="org.Hs.eg.db")


png(paste0(OUT_DIR, 'chip_seeker_', name_1, '_plotAnnoPie.png'))
plotAnnoPie(peakAnno_1)
dev.off()

png(paste0(OUT_DIR, 'chip_seeker_', name_2, '_plotAnnoPie.png'))
plotAnnoPie(peakAnno_2)
dev.off()

