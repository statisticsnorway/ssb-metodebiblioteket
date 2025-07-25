# Finction to checking links
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

# Function for checking unittests are passing
get_failing <- function(path_kat){
  suppressMessages(
    utils::capture.output(
      tt <- devtools::test()
    )
  )
  tt <- as.data.frame(tt)
  tt <- tt[tt$failed > 0, c("context", "test") ]
  if (nrow(tt) > 0) {
    tt$func <- ""
    katalog <- utils::read.csv(path_kat)
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

# Function for checking if functions are called in the file
check_func_test <- function(func_tab, line){
  for (i in 1:nrow(func_tab)){
    f <-  func_tab$funksjon_navn[i]
    func_patt <- paste0(f, "\\(")
    found <- grep(func_patt, line)
    if (length(found) != 0){
      for (l in line[found]){
        if (!grepl('^\\#', l)) {
          func_tab$status[i] <- "testet"
        }
      }
    }
  }
  func_tab$status
}