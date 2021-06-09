
setwd("~/programming/bio_project/src/")

library(ggplot2)
library(dplyr)
library(tidyr)
library(tibble)
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

#install.packages("curl")
#install.packages("xml2")
#install.packages("openssl")

#BiocManager::install("ChIPseeker")

#install.packages("ChIPseeker")



DATA_DIR <- '../data/'
OUT_DIR <- '../pictures/'

prefix_1 <- 'H3K4me1_HCT116_ENCFF699ABD'
prefix_2 <- 'H3K4me1_HCT116_ENCFF931YSQ'