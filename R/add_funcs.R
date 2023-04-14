# Functions for adding new functiond

add_func <- function(func, package, keyword = "r", url = NULL, github = F){
  kat <- read.csv('katalogdata.csv', header = T, stringsAsFactors = FALSE)
  
  if (check_func(func, package, kat) > 0) stop("Function already in library")
  if (missing(url)){
    url <- get_url(func, package, github)
  }
  new_row = data.frame(func = func, 
                       pack = package, 
                       navn = get_name(func, package),
                       description = get_description(func, package),
                       keyword = keyword,
                       url = url)
  kat <- rbind(kat, new_row)
  kat <- kat[order(kat$func), ]
  write.csv(kat, file = "katalogdata.csv",row.names=F)
}


check_func <- function(func, package, kat){
  m <- func == kat$func
  if (any(m)){
    m2 <- package == kat$pack[m]
    if (length(kat$func[m2]) > 0){
      return(length(m2))
    }
  }
  0
}


get_alias <- function(func, package){
  aliases <- readRDS(file.path(.libPaths()[1], package, "help", "aliases.rds"))
  aliases[func]
}


get_description <- function(func, package){
  db = tools::Rd_db(package)
  func <- get_alias(func, package)
  txt <- tools:::.Rd_get_text(x = db[[paste0(func, ".Rd")]])
  descrip_beg <- grep("Description", txt)
  descrip_end <- grep("Usage", txt)
  descr <- txt[(descrip_beg+1):(descrip_end -1)]
  descr <- paste(descr, collapse = " ")
  descr <- gsub("\\s+", " ", stringr::str_trim(descr))
  trimws(descr, which = "both")
}


get_url <- function(func, package, github=F){
  navn <- get_alias(func, package)
  if (github){
    url <- paste0("https://rdrr.io/github/statisticsnorway/", package, "/man/", navn, ".html")
  } else {
    url <- paste0("https://rdrr.io/cran/", package, "/man/", navn, ".html")
  }
  url
}

get_name <- function(func, package){
  db = tools::Rd_db(package)
  func <- get_alias(func, package)
  txt <- tools:::.Rd_get_text(x = db[[paste0(func, ".Rd")]])
  navn <- trimws(txt[3])
  navn
}



#### Add functions ####
#


# Kkontrollere funksjoner
add_func('validator', 'validate', keyword = "r kontrollere")
add_func('confront', 'validate', keyword = "r kontrollere")
add_func('ThError', 'Kostra', keyword = "r kontrollere", github = T)
add_func('Hb', 'Kostra', keyword = "r kontrollere", github = T)
add_func('Quartile', 'Kostra', keyword = "r kontrollere", github = T)
add_func('OutlierRegressionMicro', 'Kostra', keyword = "r kontrollere", github = T)
add_func('Rank2NumVar', 'Kostra', keyword = "r kontrollere", github = T)
add_func("Diff2NumVar", "Kostra", keyword = "r kontrollere", github = T)
add_func("AggrSml2NumVar", "Kostra", keyword = "r kontrollere", github = T)

#Imputere
add_func('impute_proxy', 'simputation', keyword = "r imputere")
add_func('impute_knn', 'simputation', keyword = "r imputere")
add_func('lm', 'stats', keyword = "r imputere analyse")
add_func('impute_pmm', 'simputation', keyword = "r imputere")
add_func('impute_rhd', 'simputation', keyword = "r imputere")

# Strukturere
add_func("HierarchyCompute", "SSBtools", keyword = "r strukturere")

# Konfidensialitet
add_func("PLSrounding", "SmallCountRounding", keyword = "r konfidensialitet")
add_func("ProtectKostra", "Kostra", keyword = "r konfidensialitet", github = T)
add_func("ProtectTable", "easySdcTable", keyword = "r konfidensialitet", github = T)

# Analyse




