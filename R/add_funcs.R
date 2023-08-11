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
#' @param url Url address to help files (if not on CRAN or available on github/pkgdown)
#' @param update T or F on whether to update the function in the dataset
#' @param description A description of the function (if not automatically fetched)
#' @param name Name of the function (if not automatically fetched)
#' 
#' 
#' @export
add_func <- function(func, package, keyword = "r", url = NULL, update=T, 
                     descrip=NULL, name=NULL){
  kat <- utils::read.csv('data/katalogdata.csv', header = T, stringsAsFactors = FALSE)
  
  if (check_func(func, package, kat) > 0) {
    if (!update) {
      stop("Function already in library. Use parameter 'update=T' to override")
    } else {
      m <- which(package == kat$pack & func == kat$func)
      kat <- kat[-m, ]
    }
  } 
  if (missing(url)){
    url <- get_url(func, package)
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
  utils::write.csv(kat, file = "data/katalogdata.csv",row.names=F)
  
  # Add to reexports list
  write_reexport(func, package)
}


write_reexport <- function(func, package){
  txt <- readLines("./R/reexports.R")
  if (!any(grepl(func, txt))){
    write(paste("#' @importFrom", package, func), "./R/reexports.R", append = T)
    write("# @export", "./R/reexports.R", append = T)
    write(paste0(package,"::", func), "R/reexports.R", append = T) 
    write("\n", "./R/reexports.R", append=T)
  }
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

#func <- "ThError"
#package <- "Kostra"
get_url <- function(func, package){
  navn <- get_alias(func, package)
  
  # try pkgdown first
  url <- paste0("https://statisticsnorway.github.io/", package, "/reference/", navn, ".html")
  if (status_code(GET(url)) == 404){
    url <- paste0("https://rdrr.io/cran/", package, "/man/", navn, ".html")
  }
  if (status_code(GET(url)) == 404){
    url <- paste0("https://rdrr.io/r/", package, "/", navn, ".html")
  }
  if (status_code(GET(url)) == 404){
    url <- paste0("https://rdrr.io/github/statisticsnorway/", package, "/man/", navn, ".html")
  }
  if (status_code(GET(url)) == 404){ 
    print(paste0("No valid url found for ", func, " in package ", package, "."))
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

get_bad_links <- function(){
  katalog <- read.csv("./data/katalogdata.csv")
  bad_links <- NULL
  for (i in 1:nrow(katalog)){
    r <- httr::GET(katalog$url[i])
    if (httr::status_code(r) == 404){
      bad_links <- c(bad_links, i)
    }
  }
  katalog[bad_links, c("func", "pack")]
}


get_failing <- function(){
  suppressMessages(
    capture.output(
      tt <- devtools::test()
    )
  )
  tt <- as.data.frame(tt)
  tt <- tt[tt$failed > 0, c("context", "test") ]
  if (nrow(tt) > 0) {
    tt$func <- ""
    katalog <- read.csv("./data/katalogdata.csv")
    for (i in 1:nrow(tt)){
      funcs <- katalog$func[katalog$pack == tt$context[i]]
      for (f in funcs){
        if (grepl(f, tt$test[i])) tt$func[i] <- f
      }
    }
    tt <- tt[, c(1, 3, 2)]
  } else {
    tt <- data.frame(matrix(ncol = 3, nrow = 0))
  }
  names(tt) <- c("pack", "func", "test")
  tt
}



