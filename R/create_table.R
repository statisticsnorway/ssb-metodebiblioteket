# Create/add to table

#### Install packages if missing ####
devtools::install_github("statisticsnorway/struktuR")
devtools::install_github("statisticsnorway/Kostra")y
devtools::install_github("statisticsnorway/SmallCountRounding")
devtools::install_github("statisticsnorway/easySdcTable")
devtools::install_github("statisticsnorway/SSBpris")
install.packages("GISSB")


#### Add functions ####
source("R/add_funcs.R")

# Kontrollere funksjoner
add_func('validator', 'validate', keyword = "r kontrollere")
add_func('confront', 'validate', keyword = "r kontrollere")
add_func('ThError', 'Kostra', keyword = "r kontrollere", github = T)
add_func('Hb', 'Kostra', keyword = "r kontrollere", github = T)
add_func('Quartile', 'Kostra', keyword = "r kontrollere", github = T)
add_func('OutlierRegressionMicro', 'Kostra', keyword = "r kontrollere", github = T)
add_func('Rank2NumVar', 'Kostra', keyword = "r kontrollere", github = T)
add_func("Diff2NumVar", "Kostra", keyword = "r kontrollere", github = T)
add_func("AggrSml2NumVar", "Kostra", keyword = "r kontrollere", github = T)
add_func("get_extremes", "struktuR", keyword = "r kontrollere", github = T)

# Imputere
add_func('impute_proxy', 'simputation', keyword = "r imputere donor")
add_func('impute_knn', 'simputation', keyword = "r imputere donor")
add_func('lm', 'stats', keyword = "r imputere analyse modellbasert")
add_func('impute_pmm', 'simputation', keyword = "r imputere donor")
add_func('impute_rhd', 'simputation', keyword = "r imputere donor")
add_func('LmImpute', 'Kostra', keyword = "r imputere modellbasert kontrollere")

# Strukturere
add_func("HierarchyCompute", "SSBtools", keyword = "r strukturere")

# Konfidensialitet
add_func("PLSrounding", "SmallCountRounding", keyword = "r konfidensialitet")
add_func("ProtectKostra", "Kostra", keyword = "r konfidensialitet", github = T)
add_func("ProtectTable", "easySdcTable", keyword = "r konfidensialitet", github = T)

# Sesongjustering


# Analyse
add_func("shortest_path_igraph", "GISSB", keyword = "r analyse nettverksanalyse romlig gis")
add_func("shortest_path_cppRouting", "GISSB", keyword = "r analyse nettverksanalyse romlig gis")

# Indeksberegning
add_func("CalcInd", "SSBpris", keyword = "r indeksberegning", github = T)
add_func("CalcIndS2", "SSBpris", keyword = "r indeksberegning usikkerhetsberegning", github = T)

# Vektberegning
add_func("struktur_model", "struktuR", keyword = "r vektberegning modellbasert", github = T, 
         url = "https://statisticsnorway.github.io/struktuR/reference/struktur_model.html")


# Usikkerhetsberegning

