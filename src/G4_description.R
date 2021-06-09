source("lib.R")

bed_df <- read.delim(paste0(DATA_DIR, 'G4_merged.bed'), as.is = TRUE, header = FALSE)
colnames(bed_df) <- c('chrom', 'start', 'end')
bed_df$len <- bed_df$end - bed_df$start

ggplot(bed_df) +
  aes(x = len) +
  geom_histogram() +
  ggtitle(paste0('G4'), subtitle = sprintf('Number of peaks = %s', nrow(bed_df))) +
  theme_bw()
ggsave(paste0('len_hist_', 'G4.png'), path = OUT_DIR)

library(ChIPseeker)
library(clusterProfiler)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
library(org.Hs.eg.db)

txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene

peakAnno <- annotatePeak(paste0(DATA_DIR, 'G4_merged.bed'), tssRegion=c(-3000, 3000), TxDb=txdb, annoDb="org.Hs.eg.db")
png(paste0(OUT_DIR, 'G4_plotAnnoPie.png'))
plotAnnoPie(peakAnno)
dev.off()
