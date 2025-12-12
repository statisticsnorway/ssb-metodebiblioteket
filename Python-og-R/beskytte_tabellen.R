# -*- coding: utf-8 -*-
# Program for å beskytte en tabell ved bruk av GaussSupression

# Hent inn biblioteket
library(GaussSuppression)

# Les inn data
tabell1 <- read.csv("/buckets/produkt/felles/r_og_python/tabell1.csv")

# Kjøre SuppressSmallCounts
tabell1_protect = SuppressSmallCounts(data = tabell1, maxN = 3, freqVar = 3, dimVar = 1:2)

# Lagre data etterpå
write.csv(tabell1_protect, file = "/buckets/produkt/felles/r_og_python/tabell1_protect.csv", row.names=FALSE)
