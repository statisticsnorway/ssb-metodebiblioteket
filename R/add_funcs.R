# Functions for adding new functiond

#func ="validator"
#package="validate"

add_func <- function(func, package, keyword = "r", url = NULL, github = F, update=F){
  kat <- read.csv('katalogdata.csv', header = T, stringsAsFactors = FALSE)
  
  if (check_func(func, package, kat) > 0) {
    if (!update) {
      stop("Function already in library. Use parameter 'update=T' to override")
    } else {
      m <- which(package == kat$pack & func == kat$func)
      kat <- kat[-m, ]
    }
  } 
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


