
source("lib.R")


for (pref in c(prefix_1, prefix_2)) {
  for (ver in c('_hg19.bed', '_hg38.bed')) {
    bed_df <- read.delim(paste0(DATA_DIR, pref, ver), as.is = TRUE, header = FALSE)
    colnames(bed_df) <- c('chrom', 'start', 'end', 'name', 'score')
    bed_df$len <- bed_df$end - bed_df$start
    
    ggplot(bed_df) +
      aes(x = len) +
      geom_histogram() +
      ggtitle(paste0(pref, ver), subtitle = sprintf('Number of peaks = %s', nrow(bed_df))) +
      theme_bw()
    ggsave(paste0('len_hist_', paste0(pref, ver), '.pdf'), path = OUT_DIR)
    
  }
}

# plot after execution of filter.sh

for (pref in c(prefix_1, prefix_2)) {
  bed_df <- read.delim(paste0(DATA_DIR, pref, '_hg19_filtered.bed'), as.is = TRUE, header = FALSE)
  colnames(bed_df) <- c('chrom', 'start', 'end', 'name', 'score')
  bed_df$len <- bed_df$end - bed_df$start
  
  ggplot(bed_df) +
    aes(x = len) +
    geom_histogram() +
    ggtitle(paste0(pref, '_hg19_filtered'), subtitle = sprintf('Number of peaks = %s', nrow(bed_df))) +
    theme_bw()
  ggsave(paste0('len_hist_', paste0(pref, '_hg19'), '_filtered.pdf'), path = OUT_DIR)
}