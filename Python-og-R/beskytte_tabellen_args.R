# -*- coding: utf-8 -*-
# Program for å beskytte en tabell ved bruk av GaussSupression

# Hent inn biblioteket
library(GaussSuppression)

# Hent inn argumentene
args <- commandArgs(trailingOnly = TRUE)
tabell_navn <- args[1]
tabell_ut <- args[2]

# Les inn data
tabell1 <- read.csv(paste0("/buckets/produkt/felles/r_og_python/", tabell_navn, ".csv"))

# Kjøre SuppressSmallCounts
tabell1_protect = SuppressSmallCounts(data = tabell1, maxN = 3, freqVar = 3, dimVar = 1:2)

# Lagre data etterpå
write.csv(tabell1_protect, 
          file = paste0("/buckets/produkt/felles/r_og_python/", tabell_ut, ".csv"), 
          row.names=FALSE)
