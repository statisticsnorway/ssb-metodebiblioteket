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
#' @param descrip A description of the function (if not automatically fetched)
#' @param name Name of the function (if not automatically fetched)
#' @param export Whether to export the function as a part of the package (True) or not.
#' @parame pack_url Adress for the online package documentation.
#' 
add_func <- function(func, package, keyword = "r", url = NULL, update=T, 
                     descrip=NULL, name=NULL, export = TRUE, pack_url=NULL){
  if (file.exists('data/katalogdata.csv')){
    kat <- utils::read.csv('data/katalogdata.csv', header = T, stringsAsFactors = FALSE)
  } else {
    kat <- data.frame(func = character(), 
                     pack = character(), 
                     navn = character(),
                     description = character(),
                     keyword = character(),
                     url = character(),
                     pack_url=character())
  }
  python = FALSE
  
  if (unlist(strsplit(keyword, " "))[1] == "python"){
    export = FALSE
    python = TRUE
  }
  
  if (check_func(func, package, kat) > 0) {
    if (!update) {
       stop("Function already in library. Use parameter 'update=T' to override")
    } else {
       m <- which(package == kat$pack & func == kat$func)
       kat <- kat[-m, ]
    }
  } 

  
  if (missing(url)){
    if (python) stop("An url is required for python functions")
    url <- get_url(func, package)
  }
  if (is.null(descrip)){
    if (python) stop("An description is required for python functions")
    descrip <- get_description(func, package)
  } 
  if (is.null(name)){
    if (python) stop("A name is required for python functions")
    name <- get_name(func, package)
  }
  if(missing(pack_url)){
    if (python) stop("An package url is required for python functions")
    pack_url <- get_pack_url(package)
  }
  
  new_row = data.frame(func = func, 
                       pack = package, 
                       navn = name,
                       description = descrip,
                       keyword = keyword,
                       url = url,
                       pack_url=pack_url)
  kat <- rbind(kat, new_row)
  kat <- kat[order(tolower(kat$func)), ]
  utils::write.csv(kat, file = "data/katalogdata.csv",row.names=F)
  
  # Add to reexports list
  if (export) {
    write_reexport(func, package)
  }
  
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
  if (httr::status_code(httr::GET(url)) == 404){
    url <- paste0("https://rdrr.io/cran/", package, "/man/", navn, ".html")
  }
  if (httr::status_code(httr::GET(url)) == 404){
    url <- paste0("https://rdrr.io/r/", package, "/", navn, ".html")
  }
  if (httr::status_code(httr::GET(url)) == 404){
    url <- paste0("https://rdrr.io/github/statisticsnorway/", package, "/man/", navn, ".html")
  }
  if (httr::status_code(httr::GET(url)) == 404){ 
    print(paste0("No valid url found for ", func, " in package ", package, "."))
  }
  url
}

get_pack_url <- function(package){
  
  # Try github.io
  url <- paste0("https://statisticsnorway.github.io/", package, "/")
  
  # Check and try cran
  if (httr::status_code(httr::GET(url)) == 404){
  url <- paste0("https://cran.r-project.org/web/packages/", package, "/index.html")
  }
  
  # Check and try github
  if (httr::status_code(httr::GET(url)) == 404){
    url <- paste0("https://github.com/statisticsnorway/", package, "/")
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

get_bad_links <- function(katalog_path){
  katalog <- utils::read.csv(katalog_path)
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
    utils::capture.output(
      tt <- devtools::test()
    )
  )
  tt <- as.data.frame(tt)
  tt <- tt[tt$failed > 0, c("context", "test") ]
  if (nrow(tt) > 0) {
    tt$func <- ""
    katalog <- utils::read.csv("./data/katalogdata.csv")
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



