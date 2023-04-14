library(tools)
library(stringr)

get_description <- function(package, func){
  db = Rd_db(package)
  txt <- tools:::.Rd_get_text(x = db[[paste0(func, ".Rd")]])
  descrip_beg <- grep("Description", txt)
  descrip_end <- grep("Usage", txt)
  descr <- txt[(descrip_beg+1):(descrip_end -1)]
  descr <- paste(descr, collapse = " ")
  descr <- gsub("\\s+", " ", str_trim(descr))
  trimws(descr, which = "both")
}



#txt <- descr[20]
check_bullet <- function(txt){
  if(is.na(txt)){
    return(FALSE)
  } else {
  txt <- trimws(txt)
  first_cond <- substr(txt, 1, 1) %in% c("-", "•")
  txt <- word(txt, 1)
  txt <- substr(txt, nchar(txt), nchar(txt))
  second_cond <- txt != ":"
  
  return(any(c(first_cond, second_cond)))
  }
}

#func = "ProtectTable"
#package = "easySdcTable"
get_parameters <- function(package, func){
  db = Rd_db(package)
  txt <- tools:::.Rd_get_text(x = db[[paste0(func, ".Rd")]])
  descrip_beg <- grep("Arguments:", txt)
  descrip_end <- min(grep("Value:", txt), 
                     grep("Details:", txt))
  descr <- txt[(descrip_beg+1):(descrip_end -1)]
  
  i = 1
  #i=16 # for methods testing
  params = c()
  descrip = c()
  while (i < length(descr)){
    
    tmp <- descr[i]
    i = i + 1
    while(descr[i] != "" | check_bullet(descr[i+1])){
      tmp <- paste(tmp, descr[i], collapse = " ")
      i = i + 1
      
    }
    tmp <- gsub("\\s+", " ", str_trim(tmp))
    tmp <- str_split(tmp, ":", n = 2, simplify = T)
    params <- c(params, trimws(tmp[1,1]))
    descrip <- c(descrip, trimws(tmp[1,2]))
    i = i+1
  }
  dt <- data.frame(Item = params, Description = descrip)
  dt
}

#func = "ProtectTable"
#package = "easySdcTable"
#func = "LmImpute"
#package = "Kostra"
get_value <- function(package, func){
  db = Rd_db(package)
  txt <- tools:::.Rd_get_text(x = db[[paste0(func, ".Rd")]])
  descrip_beg <- grep("Value:", txt)
  descrip_end <- min(grep("Examples:", txt), 
                     grep("Warning:", txt), 
                     grep("Note:", txt))
  descr <- txt[(descrip_beg+1):(descrip_end -1)]
  
  i = 1
  params = c()
  descrip = c()
  title = ""
  while (i < length(descr)){
    
    tmp <- descr[i]
    i = i +1
    while(descr[i] != "" | check_bullet(descr[i+1])){
      tmp <- paste(tmp, descr[i], collapse = " ")
      i = i+1
    }
    tmp <- gsub("\\s+", " ", str_trim(tmp))
    #tmp = "hi ds:"
    tmp2 <- str_split(tmp, ":", n = 2, simplify = T)
    #str_count(tmp2[1], '\\W+')
    # Check if more than one word before ':'
    if(str_count(tmp2[1], '\\W+') > 0){
      title <- paste(title, tmp, collapse = " ")
    #}
    #if (tmp[2] == "" | check_bullet(descr[i+1])){
    #  title <- paste(title, tmp, collapse = "")
    } else {
      params <- c(params, trimws(tmp2[1,1]))
      descrip <- c(descrip, trimws(tmp2[1,2]))
    }
    i = i+1
  }
  dt <- data.frame(Item = params, Description = descrip)
  list(dt = dt, text = title)
}

print_examples <- function(package, func){
  db = Rd_db(package)
  txt <- tools:::.Rd_get_text(x = db[[paste0(func, ".Rd")]])
  descrip_beg <- grep("Examples:", txt)
  descrip_end <- length(txt)
  descr <- txt[(descrip_beg+1):(descrip_end -1)]

  for(i in 1:length(descr)){
    cat(descr[i])
    cat("\n")
  }
}

