# -*- coding: utf-8 -*-
# Create/add to table

# Ensure Norwegian language encoding
Sys.setlocale("LC_ALL", "nb-NO.UTF-8")

#### Install packages if missing ####
devtools::install_github("statisticsnorway/ssb-struktur")
devtools::install_github("statisticsnorway/ssb-kostra")
devtools::install_github("statisticsnorway/ssb-smallcountrounding")
devtools::install_github("statisticsnorway/ssb-easySdcTable")
devtools::install_github("statisticsnorway/ssb-pris")
devtools::install_github("statisticsnorway/ssb-sdcforetakperson")
devtools::install_github("statisticsnorway/ssb-sdclonn")
devtools::install_github("statisticsnorway/ReGenesees")
install.packages("GISSB")
install.packages("GaussSupression")

# RJDemetra litt vanskelig å installere pga avhengighet på java versjon
# devtools::install_github("statisticsnorway/pickmdl")
# install.packages("RJDemetra")



#### Add functions ####
source("internal/add_funcs.R")


#### Kontrollere funksjoner ####
add_func('validator', 'validate', keyword = "rfunc kontrollere regelbasert 5.3")
add_func('confront', 'validate', keyword = "rfunc kontrollere regelbasert 5.3")

add_func('ThError', 'Kostra', keyword = "rfunc kontrollere statistisk 5.3",
         url = "https://statisticsnorway.github.io/ssb-kostra/reference/ThError.html",
         pack_url = "https://statisticsnorway.github.io/ssb-kostra/index.html")

add_func('Hb', 'Kostra', keyword = "rfunc kontrollere statistisk 5.3",
         url = "https://statisticsnorway.github.io/ssb-kostra/reference/Hb.html",
         pack_url = "https://statisticsnorway.github.io/ssb-kostra/index.html")

add_func('Quartile', 'Kostra', keyword = "rfunc kontrollere statistisk 5.3",
         url = "https://statisticsnorway.github.io/ssb-kostra/reference/Quartile.html",
         pack_url = "https://statisticsnorway.github.io/ssb-kostra/index.html")

add_func('OutlierRegressionMicro', 'Kostra', keyword = "rfunc kontrollere statistisk 5.3",
         url = "https://statisticsnorway.github.io/ssb-kostra/reference/OutlierRegressionMicro.html",
         pack_url = "https://statisticsnorway.github.io/ssb-kostra/index.html")

add_func('Rank2NumVar', 'Kostra', keyword = "rfunc kontrollere statistisk 5.3",
         url = "https://statisticsnorway.github.io/ssb-kostra/reference/Rank2NumVar.html",
         pack_url = "https://statisticsnorway.github.io/ssb-kostra/index.html")

add_func("Diff2NumVar", "Kostra", keyword = "rfunc kontrollere statistisk 5.3",
         url = "https://statisticsnorway.github.io/ssb-kostra/reference/Diff2NumVar.html",
         pack_url = "https://statisticsnorway.github.io/ssb-kostra/index.html")

add_func("AggrSml2NumVar", "Kostra", keyword = "rfunc kontrollere statistisk 5.3",
         url = "https://statisticsnorway.github.io/ssb-kostra/reference/AggrSml2NumVar.html",
         pack_url = "https://statisticsnorway.github.io/ssb-kostra/index.html")


add_func("get_extremes", "struktuR", keyword = "rfunc kontrollere statistisk 5.3",
         url="https://statisticsnorway.github.io/ssb-struktur/reference/get_extremes.html")
add_func("get_extremes", "statstruk", keyword = "python kontrollere statistisk 5.3",
         name="Get extremes",
         url = "https://statisticsnorway.github.io/ssb-statstruk/reference.html#statstruk.ratemodel.ratemodel.get_extremes",
         pack_url="https://statisticsnorway.github.io/ssb-statstruk/",
         descrip = "Get observations with extreme values based on their rstudized residual value or G value.")

#### Imputere ####
add_func('modifier', 'dcmodify', keyword = "rfunc imputere regelbasert 5.4")
add_func('impute_proxy', 'simputation', keyword = "rfunc imputere donor 5.4")
add_func('impute_knn', 'simputation', keyword = "rfunc imputere donor 5.4")
add_func('lm', 'stats', keyword = "rfunc imputere analyse modellbasert 5.4 5.7",
         name = 'Fitting Linear Models', 
         descrip = "'lm' is used to fit linear models. It can be used to carry out regression, single stratum analysis of variance and analysis of covariance (although aov may provide a more convenient interface for these).",
         url = "https://search.r-project.org/R/refmans/stats/html/lm.html",
         pack_url="https://search.r-project.org/R/refmans/stats/html/00Index.html"
         )
#add_func('impute_pmm', 'simputation', keyword = "rfunc imputere donor") # bugs in function
add_func('impute_rhd', 'simputation', keyword = "rfunc imputere donor 5.4")
add_func('LmImpute', 'Kostra', keyword = "rfunc imputere modellbasert kontrollere statistisk 5.4",
         url = "https://statisticsnorway.github.io/ssb-kostra/reference/LmImpute.html",
         pack_url = "https://statisticsnorway.github.io/ssb-kostra/index.html")
add_func('SVC', 'sklearn.svm', keyword='python imputere maskinlaering 5.2 5.4',
         name="C-Support Vector Classification.",
         descrip = 'The implementation is based on libsvm. The fit time scales at least quadratically with the number of samples and may be impractical beyond tens of thousands of samples.',
         url="https://scikit-learn.org/stable/modules/generated/sklearn.svm.SVC.html#sklearn.svm.SVC", 
         pack_url = "https://scikit-learn.org/stable/index.html",
         export = FALSE)
add_func('CountVectorizer', 'sklearn.feature_extraction.text', keyword='python strukturere maskinlaering 5.2',
         name="Count vectorizer",
         descrip = 'Convert a collection of text documents to a matrix of token counts.',
         url="https://scikit-learn.org/stable/modules/generated/sklearn.feature_extraction.text.CountVectorizer.html", 
         pack_url = "https://scikit-learn.org/stable/index.html",
         export = FALSE)
add_func('OLS', 'statsmodels.regression.linear_model', keyword='python imputere modellbasert vektberegning analyse 5.4 5.7',
         name="Ordinary Least Squares",
         descrip = 'Convert a collection of text documents to a matrix of token counts.',
         url="https://www.statsmodels.org/stable/generated/statsmodels.regression.linear_model.OLS.html", 
         pack_url = "https://www.statsmodels.org/stable/index.html",
         export = FALSE)

#### Strukturere ####
add_func("HierarchyCompute", "SSBtools", keyword = "rfunc strukturere 5.7")
add_func("tables_by_formulas", "SSBtools", keyword = "rfunc strukturere 5.7", 
         url = "https://statisticsnorway.github.io/ssb-ssbtools/reference/tables_by_formulas.html")
add_func("model_aggregate", "SSBtools", keyword = "rfunc strukturere 5.7 6.2")

#### Konfidensialitet ####



add_func("PLSroundingPublish", "SmallCountRounding", keyword = "rfunc konfidensialitet avrunding 6.4", 
         url = "https://statisticsnorway.github.io/ssb-smallcountrounding/reference/PLSrounding.html")
add_func("ProtectKostra", "Kostra", keyword = "rfunc konfidensialitet undertrykking 6.4",
         url = "https://statisticsnorway.github.io/ssb-kostra/reference/ProtectKostra.html",
         pack_url = "https://statisticsnorway.github.io/ssb-kostra/index.html")
add_func("ProtectTableData", "easySdcTable", keyword = "rfunc konfidensialitet undertrykking 6.4" )
add_func("SdcForetakPerson", "SdcForetakPerson", keyword = "rfunc konfidensialitet undertrykking avrunding 6.4",
         url="https://statisticsnorway.github.io/ssb-sdcforetakperson/reference/SdcForetakPerson.html")
add_func("SuppressSmallCounts", "GaussSuppression", keyword = "rfunc konfidensialitet undertrykking 6.4",
         url = "https://statisticsnorway.github.io/ssb-gausssuppression/reference/SuppressSmallCounts.html")
add_func("SuppressDominantCells", "GaussSuppression", keyword = "rfunc konfidensialitet undertrykking 6.4",
         url = "https://statisticsnorway.github.io/ssb-gausssuppression/reference/SuppressDominantCells.html")
add_func("SuppressFewContributors", "GaussSuppression", keyword = "rfunc konfidensialitet undertrykking 6.4",
         url = "https://statisticsnorway.github.io/ssb-gausssuppression/reference/SuppressFewContributors.html")
add_func("SuppressKDisclosure", "GaussSuppression", keyword = "rfunc konfidensialitet undertrykking 6.4",
         url = "https://statisticsnorway.github.io/ssb-gausssuppression/reference/SuppressKDisclosure.html")
add_func("GaussSuppressionFromData", "GaussSuppression", keyword = "rfunc konfidensialitet undertrykking 6.4",
         url = "https://statisticsnorway.github.io/ssb-gausssuppression/reference/GaussSuppressionFromData.html")
add_func("GaussSuppressDec", "GaussSuppression", keyword = "rfunc konfidensialitet undertrykking 6.4",
         url = "https://statisticsnorway.github.io/ssb-gausssuppression/reference/GaussSuppressDec.html")
add_func("SuppressionFromDecimals", "GaussSuppression", keyword = "rfunc konfidensialitet undertrykking 6.4",
         url = "https://statisticsnorway.github.io/ssb-gausssuppression/reference/SuppressionFromDecimals.html")
add_func("SuppressLinkedTables", "GaussSuppression", keyword = "rfunc konfidensialitet undertrykking 6.4",
         url = "https://statisticsnorway.github.io/ssb-gausssuppression/reference/SuppressLinkedTables.html")
add_func("sdc_lonn", "sdclonn", keyword = "rfunc konfidensialitet undertrykking 6.4", 
         url="https://statisticsnorway.github.io/ssb-sdclonn/reference/sdc_lonn.html", 
         pack_url = "https://statisticsnorway.github.io/ssb-sdclonn/reference/index.html")


# +
### SESONGJUSTERING OG TIDSSERIEANALYSE ###
# export = False for all in RJDemetra and pickmdl due to difficulties in installing 
#  BUT NOW CHANGED TO export = TRUE
add_func("x13", "RJDemetra", keyword = "rfunc sesongjustering 6.1",
         name = "Seasonal Adjustment with X13-ARIMA",
         descrip = "Functions to estimate the seasonally adjusted series (sa) with the X13-ARIMA method. This is achieved by decomposing the time series (y) into the trend-cycle (t), the seasonal component (s) and the irregular component (i). The final seasonally adjusted series shall be free of seasonal and calendar-related movements. x13 returns a preformatted result while jx13 returns the Java objects resulting from the seasonal adjustment.",
         export = TRUE) 
add_func("x13_spec", "RJDemetra", keyword = "rfunc sesongjustering 6.1", 
        name = "X-13ARIMA model specification, SA/X13",
        descrip = 'Function to create (and/or modify) a c("SA_spec", "X13") class object with the SA model specification for the X13 method. It can be done from a pre-defined "JDemetra+" model specification (a character), a previous specification (c("SA_spec", "X13") object) or a seasonal adjustment model (c("SA", "X13") object).',
        export = TRUE) 
add_func("x13_pickmdl", "pickmdl", keyword = "rfunc sesongjustering 6.1" , url="https://statisticsnorway.github.io/ssb-pickmdl/reference/x13_pickmdl.html",
    name = "x13 with PICKMDL and partial concurrent possibilities",
    descrip="x13 can be run as usual (automdl) or with a PICKMDL specification. The ARIMA model, outliers and filters can be identified at a certain date and then held fixed (with a new outlier-span).",
    export = TRUE)

add_func("x13_automdl", "pickmdl", keyword = "rfunc sesongjustering 6.1", 
         url="https://statisticsnorway.github.io/ssb-pickmdl/reference/x13_pickmdl.html",
    name = "x13 with PICKMDL and partial concurrent possibilities",
    descrip = "x13 can be run as usual (automdl) or with a PICKMDL specification. The ARIMA model, outliers and filters can be identified at a certain date and then held fixed (with a new outlier-span).",
    export = TRUE)
add_func("x13_both", "pickmdl", keyword = "rfunc sesongjustering 6.1", 
         url="https://statisticsnorway.github.io/ssb-pickmdl/reference/x13_both.html",
    name = "x13_spec and x13_pickmdl wrapped as a single function",
    descrip = "Output is determined by the parameter: both_output.",
    export = TRUE)
add_func("x13_text_frame", "pickmdl", keyword = "rfunc sesongjustering 6.1", 
         url="https://statisticsnorway.github.io/ssb-pickmdl/reference/x13_text_frame.html",
         pack_url="https://github.com/statisticsnorway/pickmdl/",
         name = "Multiple x13_both runs with code input from a data frame",
         descrip = "Gjør det mulig med sesongjustering av mange serier basert på parametere i en data.frame (f.eks lest inn fra en excel-fil).",
         export = TRUE)
add_func("konstruksjon", "pickmdl", keyword = "rfunc sesongjustering 6.1", 
         url="https://statisticsnorway.github.io/ssb-pickmdl/reference/konstruksjon.html",
         pack_url="https://github.com/statisticsnorway/pickmdl/",
         name = "Lage faktorer for kalendereffekter",
         descrip = "Fleksibel funksjon som lager ulike kalendervariable, som f.eks. TD-, WD- og påskevariable, tilpasset norske forhold.",
         export = TRUE)

add_func(func="sa_quality_report", package="sadashboard", keyword = "rfunc sesongjustering 6.1", 
         url="https://statisticsnorway.github.io/ssb-sadashboard/reference/sa_quality_report.html",
         descrip = "Wrapper function for creating a html-document with interactive quality report for seasonal adjustment with RJdemetra. The quality report includes tables with selected quality indicators. User may also choose to include interactive plots of seasonally adjusted time series.",
         name = "Quality Report for Seasonal Adjustment with RJDemetra",
         export = TRUE, 
         pack_url="https://github.com/statisticsnorway/ssb-sadashboard/")

add_func(func="make_paramfile", package="sadashboard", keyword = "rfunc sesongjustering 6.1", 
         url="https://statisticsnorway.github.io/ssb-sadashboard/reference/make_paramfile.html",
         descrip = "Oppretter en initial parameterfil der alle verdiene i en kolonne er de samme",
         name = "Create an initial parameter file where all values in a column are the same",
         export = TRUE, 
         pack_url="https://github.com/statisticsnorway/ssb-sadashboard/")

add_func(func="add_constraint", package="sadashboard", keyword = "rfunc sesongjustering 6.1", 
         url="https://statisticsnorway.github.io/ssb-sadashboard/reference/add_constraint.html",
         descrip = "Legger til en opsjon(kolonne) i spesifikasjonsfil objektet og åpner det for redigering med R-pakken DataEditR",
         name = "Add a constraint to a constraint data frame object and open for editing.",
         export = TRUE,
         pack_url="https://github.com/statisticsnorway/ssb-sadashboard/")

add_func(func="edit_constraints", package="sadashboard", keyword = "rfunc sesongjustering 6.1", 
         url="https://statisticsnorway.github.io/ssb-sadashboard/reference/edit_constraints.html",
         descrip = "For redigering av celler spesifikasjonsfil objektet og åpner det for redigering med R-pakken DataEditR",
         name = "Edit a constraint data frame object.",
         export = TRUE, 
         pack_url="https://github.com/statisticsnorway/ssb-sadashboard/")



# -

#### Analyse ####
add_func("shortest_path_igraph", "GISSB", keyword = "rfunc analyse romlig")
add_func("shortest_path_cppRouting", "GISSB", keyword = "rfunc analyse romlig")

#### Indeksberegning ####
add_func("CalcInd", "SSBpris", keyword = "rfunc indeksberegning 5.6 5.7", url ="https://statisticsnorway.github.io/ssb-pris/reference/CalcInd.html")
add_func("CalcIndS2", "SSBpris", keyword = "rfunc indeksberegning usikkerhetsberegning 5.6 5.7", url = "https://statisticsnorway.github.io/ssb-pris/reference/CalcIndS2.html")

#### Vektberegning ####
add_func("struktur_model", "struktuR", keyword = "rfunc vektberegning modellbasert 5.6 5.7", 
         url = "https://statisticsnorway.github.io/ssb-struktur/reference/struktur_model.html")
add_func("quantile_weighted", "SSBtools", keyword = "rfunc analyse vektberegning 5.6")
add_func("ratemodel", "statstruk", keyword = "python vektberegning modellbasert 5.7",
         name="ratemodel module",
         url = "https://statisticsnorway.github.io/ssb-statstruk/reference.html#statstruk.ratemodel.ratemodel",
         pack_url="https://statisticsnorway.github.io/ssb-statstruk/",
         descrip = "Class for estimating statistics for business surveys using a rate model.")
add_func("get_estimates", "statstruk", keyword = "python vektberegning modellbasert usikkerhetsberegning 5.7",
         name="Get Estimates",
         url = "https://statisticsnorway.github.io/ssb-statstruk/reference.html#statstruk.ratemodel.ratemodel.get_estimates",
         pack_url="https://statisticsnorway.github.io/ssb-statstruk/",
         descrip = "Get estimates for previously run model within strata or domains. Variance and CV estimates are returned for each domain.")
add_func("get_weights", "statstruk", keyword = "python vektberegning modellbasert 5.6",
         name="Get weights",
         url = "https://statisticsnorway.github.io/ssb-statstruk/reference.html#statstruk.ratemodel.ratemodel.get_weights",
         pack_url="https://statisticsnorway.github.io/ssb-statstruk/",
         descrip = "Get sample data with weights based on model.")

# ReGenesees functions
add_func("e.svydesign", "ReGenesees", keyword = "rfunc vektberegning 5.6", 
         url="https://diegozardetto.github.io/ReGenesees/reference/e.svydesign.html")
add_func("pop.template", "ReGenesees", keyword = "rfunc vektberegning 5.6 5.7", 
         url="https://diegozardetto.github.io/ReGenesees/reference/pop.template.html")
add_func("fill.template", "ReGenesees", keyword = "rfunc vektberegning 5.6 5.7", 
         url="https://diegozardetto.github.io/ReGenesees/reference/fill.template.html")
add_func("e.calibrate", "ReGenesees", keyword = "rfunc vektberegning 5.6 5.7", 
         url="https://diegozardetto.github.io/ReGenesees/reference/e.calibrate.html")
add_func("weights", "ReGenesees", keyword = "rfunc vektberegning 5.6", 
         url="https://diegozardetto.github.io/ReGenesees/reference/weights.html")
add_func("svystatTM", "ReGenesees", keyword = "rfunc vektberegning 5.7", 
         url="https://diegozardetto.github.io/ReGenesees/reference/svystatTM.html")
add_func("svystatL", "ReGenesees", keyword = "rfunc vektberegning 5.7", 
         url="https://diegozardetto.github.io/ReGenesees/reference/svystatL.html")

# Usikkerhetsberegning
add_func("CalibrateSSB", "CalibrateSSB", keyword = "rfunc vektberegning usikkerhetsberegning designbasert 5.6")
add_func("PanelEstimation", "CalibrateSSB", keyword = "rfunc vektberegning usikkerhetsberegning designbasert 5.7")


