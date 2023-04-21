# Create/add to table

#### Install packages if missing ####
devtools::install_github("statisticsnorway/struktuR")
devtools::install_github("statisticsnorway/Kostra")
devtools::install_github("statisticsnorway/SmallCountRounding")
devtools::install_github("statisticsnorway/easySdcTable")
devtools::install_github("statisticsnorway/SSBpris")
devtools::install_github("statisticsnorway/pickmdl")
devtools::install_github("statisticsnorway/SdcForetakPerson")
install.packages("GISSB")
install.packages("RJDemetra")
install.packages("GaussSupression")


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
add_func("model_aggregate", "SSBtools", keyword = "r strukturere 6.2")

# Konfidensialitet
add_func("PLSroundingPublish", "SmallCountRounding", keyword = "r konfidensialitet avrunding")
add_func("ProtectKostra", "Kostra", keyword = "r konfidensialitet undertrykking", github = T)
add_func("ProtectTableData", "easySdcTable", keyword = "r konfidensialitet undertrykking", github = T)
add_func("SdcForetakPerson", "SdcForetakPerson", keyword = "r konfidensialitet undertrykking avrunding", github = T)

add_func("SuppressSmallCounts", "GaussSuppression", keyword = "r konfidensialitet undertrykking")
add_func("SuppressDominantCells", "GaussSuppression", keyword = "r konfidensialitet undertrykking")
add_func("SuppressFewContributors", "GaussSuppression", keyword = "r konfidensialitet undertrykking")
add_func("SuppressKDisclosure", "GaussSuppression", keyword = "r konfidensialitet undertrykking")
add_func("GaussSuppressionFromData", "GaussSuppression", keyword = "r konfidensialitet undertrykking")
add_func("GaussSuppressDec", "GaussSuppression", keyword = "r konfidensialitet undertrykking")
add_func("SuppressionFromDecimals", "GaussSuppression", keyword = "r konfidensialitet undertrykking")


# Sesongjustering - missing html for functions in pickmdl. Can't install with Java
#add_func("x13", "RJDemetra", keyword = "r sesongjustering")
#add_func("x13_spec", "RJDemetra", keyword = "r sesongjustering")
#add_func("x13_pickmdl", "pickmdl", keyword = "r sesongjustering", github = T, url="https://github.com/statisticsnorway/pickmdl/blob/main/man/x13_pickmdl.Rd")
#add_func("x13_automdl", "pickmdl", keyword = "r sesongjustering", github = T, url="https://github.com/statisticsnorway/pickmdl/blob/main/man/x13_pickmdl.Rd")
#add_func("x13_both", "pickmdl", keyword = "r sesongjustering", github = T, url="https://github.com/statisticsnorway/pickmdl/blob/main/man/x13_both.Rd")


# Analyse
add_func("shortest_path_igraph", "GISSB", keyword = "r analyse nettverksanalyse romlig gis")
add_func("shortest_path_cppRouting", "GISSB", keyword = "r analyse nettverksanalyse romlig gis")

# Indeksberegning
add_func("CalcInd", "SSBpris", keyword = "r indeksberegning", github = T)
add_func("CalcIndS2", "SSBpris", keyword = "r indeksberegning usikkerhetsberegning", github = T)

# Vektberegning
add_func("struktur_model", "struktuR", keyword = "r vektberegning modellbasert", github = T, 
         url = "https://statisticsnorway.github.io/struktuR/reference/struktur_model.html")
add_func("quantile_weighted", "SSBtools", keyword = "r analyse vektberegning")


# Usikkerhetsberegning
add_func("CalibrateSSB", "CalibrateSSB", keyword = "r vektberegning usikkerhetberegning designbasert")
add_func("PanelEstimation", "CalibrateSSB", keyword = "r vektberegning usikkerhetberegning designbasert")



