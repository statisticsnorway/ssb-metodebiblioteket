# Functions for adding new function to library

# Run add_func() for function
# Add unittest (new file if package not listed)
# Add to imports if a new R package
# Add to remotes if only on github

#func ="validator"
#package="validate"

#'Add function to Metodebiblioteket
#'
#'
#' @param func Function name
#' @param package Package name
#' @param keyword keywords to use seperated by a space
#' @param url Url address to help files (if not on CRAN or available on github)
#' @param github T or F for if it is a github only package
#' @param update T or F on whether to update the function in the dataset
#' 
#' @export
add_func <- function(func, package, keyword = "r", url = NULL, github = F, update=F, 
                     descrip=NULL, name=NULL){
  kat <- read.csv('data/katalogdata.csv', header = T, stringsAsFactors = FALSE)
  
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
  if (is.null(descrip)){
    descrip <- get_description(func, package)
  } 
  if (is.null(name)){
    name <- get_name(func, package)
  }
  new_row = data.frame(func = func, 
                       pack = package, 
                       navn = name,
                       description = descrip,
                       keyword = keyword,
                       url = url)
  kat <- rbind(kat, new_row)
  kat <- kat[order(kat$func), ]
  write.csv(kat, file = "data/katalogdata.csv",row.names=F)
  
  # Add to reexports list
  write_reexport(func, package)
}


write_reexport <- function(func, package){
  write(paste("#' @importFrom", package, func), "./R/reexports.R", append = T)
  write("# @export", "./R/reexports.R", append = T)
  write(paste0(package,"::", func), "R/reexports.R", append = T) 
  write("\n", "./R/reexports.R", append=T)
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


