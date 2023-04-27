# Create/add to table

#### Install packages if missing ####
devtools::install_github("statisticsnorway/struktuR")
devtools::install_github("statisticsnorway/Kostra")
devtools::install_github("statisticsnorway/SmallCountRounding")
devtools::install_github("statisticsnorway/easySdcTable")
devtools::install_github("statisticsnorway/SSBpris")
devtools::install_github("statisticsnorway/SdcForetakPerson")
devtools::install_github("DiegoZardetto/ReGenesees")
install.packages("GISSB")
install.packages("GaussSupression")


# RJDemetra litt vanskelig å installere pga avhengighet på java versjon
# devtools::install_github("statisticsnorway/pickmdl")
# install.packages("RJDemetra")


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
add_func("PLSroundingPublish", "SmallCountRounding", keyword = "r konfidensialitet avrunding 6.4")
add_func("ProtectKostra", "Kostra", keyword = "r konfidensialitet undertrykking 6.4", github = T)
add_func("ProtectTableData", "easySdcTable", keyword = "r konfidensialitet undertrykking 6.4", github = T)
add_func("SdcForetakPerson", "SdcForetakPerson", keyword = "r konfidensialitet undertrykking avrunding 6.4", github = T)

add_func("SuppressSmallCounts", "GaussSuppression", keyword = "r konfidensialitet undertrykking 6.4")
add_func("SuppressDominantCells", "GaussSuppression", keyword = "r konfidensialitet undertrykking 6.4")
add_func("SuppressFewContributors", "GaussSuppression", keyword = "r konfidensialitet undertrykking 6.4")
add_func("SuppressKDisclosure", "GaussSuppression", keyword = "r konfidensialitet undertrykking 6.4")
add_func("GaussSuppressionFromData", "GaussSuppression", keyword = "r konfidensialitet undertrykking 6.4")
add_func("GaussSuppressDec", "GaussSuppression", keyword = "r konfidensialitet undertrykking 6.4")
add_func("SuppressionFromDecimals", "GaussSuppression", keyword = "r konfidensialitet undertrykking 6.4")


# Sesongjustering - missing html for functions in pickmdl. Can't install with Java so use manual

add_func("x13", "RJDemetra", keyword = "r sesongjustering 6.1", url="https://rdrr.io/cran/RJDemetra/man/x13.html",
         name = "Seasonal Adjustment with X13-ARIMA",
         descrip = "Functions to estimate the seasonally adjusted series (sa) with the X13-ARIMA method. This is achieved by decomposing the time series (y) into the trend-cycle (t), the seasonal component (s) and the irregular component (i). The final seasonally adjusted series shall be free of seasonal and calendar-related movements. x13 returns a preformatted result while jx13 returns the Java objects resulting from the seasonal adjustment.")
add_func("x13_spec", "RJDemetra", keyword = "r sesongjustering 6.1", url = "https://rdrr.io/cran/RJDemetra/man/x13_spec.html",
        name = "X-13ARIMA model specification, SA/X13",
        descrip = 'Function to create (and/or modify) a c("SA_spec", "X13") class object with the SA model specification for the X13 method. It can be done from a pre-defined "JDemetra+" model specification (a character), a previous specification (c("SA_spec", "X13") object) or a seasonal adjustment model (c("SA", "X13") object).')
add_func("x13_pickmdl", "pickmdl", keyword = "r sesongjustering 6.1", github = T, url="https://github.com/statisticsnorway/pickmdl/blob/main/man/x13_pickmdl.Rd",
      name = "x13 with PICKMDL and partial concurrent possibilities",
      descrip="x13 can be run as usual (automdl) or with a PICKMDL specification. The ARIMA model, outliers and filters can be identified at a certain date and then held fixed (with a new outlier-span).")
add_func("x13_automdl", "pickmdl", keyword = "r sesongjustering 6.1", github = T, url="https://github.com/statisticsnorway/pickmdl/blob/main/man/x13_pickmdl.Rd",
    name = "x13 with PICKMDL and partial concurrent possibilities",
    descrip = "x13 can be run as usual (automdl) or with a PICKMDL specification. The ARIMA model, outliers and filters can be identified at a certain date and then held fixed (with a new outlier-span).")
add_func("x13_both", "pickmdl", keyword = "r sesongjustering 6.1", github = T, url="https://github.com/statisticsnorway/pickmdl/blob/main/man/x13_both.Rd",
         name = "x13_spec and x13_pickmdl wrapped as a single function",
         descrip = "Output is determined by the parameter: both_output.")


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


