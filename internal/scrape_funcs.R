
# Check for github pat
if (Sys.getenv("GITHUB_PAT") == ""){
  Sys.setenv(GITHUB_PAT = getPass::getPass())
}


#' Get url to R, python and ipynb in a repo
#'
#' @param repo Name of the repo (at StatisticsNorway)
#' @param github_token Token so can find internal sites
#' @param silent Logic for if printing should be repressed.
#'
#' @return list of 3 elements: R files, python files and notebook files.
get_repo_urls <- function(repo, github_token, silent = TRUE){
  url <- paste0("https://api.github.com/repos/statisticsnorway/", repo, "/contents")
  response <- httr::GET(url, httr::add_headers(Authorization = paste0("Bearer ", github_token)))
  contents <- httr::content(response)
  if (!is.null(contents$message)){
    if (!silent){
      print(paste("No files found in repo: ", repo))
    }
    return(list(r_files = character(), py_files=character(), nb_files=character()))
  }
  all_files <- traverse_directory(contents, github_token = github_token)
  
  r_files <- all_files[grepl("\\.R\\?ref\\=", all_files, ignore.case = TRUE)]
  py_files <- all_files[grepl("\\.py\\?ref\\=", all_files, ignore.case = TRUE)]
  nb_files <- all_files[grepl("\\.ipynb\\?ref\\=", all_files, ignore.case = TRUE)]
  
  list(r_files = r_files, py_files=py_files, nb_files=nb_files)
}


#' Get url to files
#'
#' @param repos Repository
#' @param github_token 
#'
#' @return dataset with urls
#' @export
get_urls <- function(repos, github_token, silent=TRUE){
  url_data <- data.frame(repo = character(), url = character(), format = character())
  n <- length(repos)
  nr <- 1
  for (r in repos){
    if (!silent){
    print(paste0("Getting urls for repo nr ", nr, " of ", n, ": " , r))
  }
    u <- get_repo_urls(r, github_token, silent = silent)
    if (length(u$r_files) > 0){
      url_data <- rbind(url_data, data.frame(repo = r, url = u$r_files, format = "R"))
    }
    if (length(u$py_files) > 0){
      url_data <- rbind(url_data, data.frame(repo = r, url = u$py_files, format = "py"))
    }
    if (length(u$nb_files) > 0){
      url_data <- rbind(url_data, data.frame(repo = r, url = u$nb_files, format = "nb"))
    }
    nr <- nr + 1
  }
  url_data
}


get_repo_tree <- function(repo, branch) {
  url <- paste0("https://api.github.com/repos/statisticsnorway/", repo, "/git/trees/", branch, "?recursive=1")
  response <- httr::GET(url, httr::add_headers(Authorization = paste0("Bearer ", Sys.getenv("GITHUB_PAT"))))
  
  if (httr::status_code(response) == 200) {
    content <- httr::content(response, as = "text", encoding = "UTF-8")
    json_content <- jsonlite::fromJSON(content)
    return(json_content$tree)
  } else {
    print(paste(repo, "not found"))
    return(NULL)
  }
}


#' Check which repos a function is found in
#'
#' @param func  Function to check
#' @param url_data Data set with list of url addresses
#' @param github_token Token to use to acces github
#' @param type To check in R ("R") or python ("py") files. 
#'
#' @return Data frame
#' @export
check_func <- function(func, url_data, github_token, type = "R", silent = TRUE){
  if (type == "R"){
    urls <- url_data[url_data$format %in% c("R", "nb"),]
  }
  if (type == "py"){
    urls <- url_data[url_data$format %in% c("py", "nb"),]
  }
  urls$count <- 0
  counts <- matrix(data=NA, nrow=nrow(urls), length(func))
  for (i in 1:nrow(urls)){
    if (!silent) print(paste0("Checking url: ", urls$url[i]))
    response <- httr::GET(urls$url[i], httr::add_headers(Authorization = paste0("Bearer ", github_token)))
    if (status_code(response) == 404) next()
    file_content <- content(response)$content
    function_code <- rawToChar(base64enc::base64decode(file_content))
    for (f in 1:length(func)){
        counts[i, f] <- str_count(function_code, paste0(func[f], "\\(")) ### this not working???
    }
  }
  dt <- cbind(data.frame(counts), repo = urls$repo)
  names(dt)[1:length(func)] <- func
  dt <- aggregate( .~repo, data=dt, FUN = sum, na.rm=TRUE)
  dt
}




#' Get list of repositories in an organisation
#'
#' @param org Name of organisation
#' @param github_token Token
#' @param type What type of repos to return. Can be "all", "stat" or "kurs".
#'
#' @return repository names
get_repos <- function(github_token = Sys.getenv("GITHUB_PAT"), type = "all"){
  
  if (github_token == ""){
    github_token = Sys.setenv(GITHUB_PAT = getPass::getPass("Github token:"))
  }
  
  url <- paste0("https://api.github.com/orgs/statisticsnorway/repos")
  
  repository_names <- character()
  page <- 1
  
  while (TRUE) {
    
    # Send the GET request to retrieve the organization's repositories for the current page
    response <- httr::GET(url, httr::add_headers(Authorization = paste0("Bearer ", github_token)),
                    query = list(per_page = 100, page = page))
    
    # Extract names
    if (httr::http_type(response) == "application/json") {
      repositories <- httr::content(response)
      page_repository_names <- sapply(repositories, function(repo) repo[["name"]])
      repository_names <- c(repository_names, page_repository_names)
      
      # Check if there are more pages to fetch
      if (length(repositories) < 100)
        break
      
      # Increment the page number
      page <- page + 1
    } else {
      print("Error: Unable to fetch repository names.")
      break
    }
  }
  
  if (type == "all"){
    return(repository_names)
  }
  if (type == "stat"){
    return(repository_names[grepl("^stat-", repository_names)])
  }
  if (type == "kurs"){
    return(repository_names[grepl("^kurs-", repository_names)])
  }
}

# from dapla-kompetanse
get_repo_info <- function(repo){
  url <- paste0("https://api.github.com/repos/statisticsnorway/", repo)
  response <- httr::GET(url, httr::add_headers(
    Authorization = paste0("Bearer ", Sys.getenv("GITHUB_PAT")))
  )
  if (httr::status_code(response) == 200){
    repo_info <- jsonlite::fromJSON(httr::content(response, as = "text"))
    branch <- repo_info$default_branch
    notempty <- ifelse(repo_info$size == 0, 0, 1)
    return(c(branch, notempty))
  } else {
    return(c("invalid", "invalid"))
  }
}

find_functions <- function(repos_to_check){

  # Collect functions to find from katalog
  katalog <- read.csv("data/katalogdata.csv")
  cond_r <- grepl("^rfunc", katalog$keyword)
  cond_py <- grepl("^python", katalog$keyword)
  
  r_funcs <- katalog$func[cond_r]
  py_funcs <- katalog$func[cond_py]

  # Set up datasets
  r_data <- create_empty_data(r_funcs, repos_to_check)
  py_data <- create_empty_data(py_funcs, repos_to_check)
  
  t <- Sys.time()
  
  n <- length(repos_to_check)
  
  # Loop through repos to find functions
  for (i in 1:n){
    r <- repos_to_check[i]
    
    # get branch name
    info <- get_repo_info(r)
    
    # Get structure of repo and identify R and python files (and ipynb)
    tree <- get_repo_tree(r, branch = info[1])
    r_urls <- fetch_url(tree, type ="R")
    py_urls <- fetch_url(tree, type = "python")
    nb_urls <- fetch_url(tree, type = "nb")
    
    # Check for functions in the R files
    if (length(r_urls) > 0){
      for (u in r_urls){
        code <- fetch_code(u)
        func_in_code <- sapply(r_funcs, FUN=in_code, code=code)
        r_data[func_in_code, i] <- 1
      }
    }
    
    # Check for functions in the python files
    if (length(py_urls) > 0){ 
      for (u in py_urls){
        code <- fetch_code(u)
        func_in_code <- sapply(py_funcs, FUN=in_code, code=code)
        py_data[func_in_code, i] <- 1
      }
    }
    
    # Check for functions in the ipynb files
    if (length(nb_urls) > 0){ 
      for (u in nb_urls){
        code <- fetch_code(u)
        
        func_in_code <- sapply(r_funcs, FUN=in_code, code=code)
        r_data[func_in_code, i] <- 1
        
        func_in_code <- sapply(py_funcs, FUN=in_code, code=code)
        py_data[func_in_code, i] <- 1
      }
    }
    
    # Wait if 50 urls have been called (to avoid rate limit)
    if (i%%50 == 0){
      rate_limit_info <- check_rate_limit()
      print("Rate limit information: ")
      print(rate_limit_info)
      
      if (rate_limit_info$remaining < 1200){
        print("Sleeping for 45 minutes")
        Sys.sleep(2700) # sleep for 45 mins
      }
    }
    print(paste0("Scraping ", r, " completed (", i, "/", n, ")"))
  }
  
  print(paste0("Scraping completed with time: ", round(Sys.time() - t), " seconds."))
  rbind(r_data, py_data)
}


in_code <- function(func, code){
  found <- grepl(paste0(func,"\\("), code)
  found
}


create_empty_data <- function(func_list, repo_list){
  dt <- data.frame(matrix(0, nrow = length(func_list), ncol = length(repo_list)))
  colnames(dt) <- repo_list
  rownames(dt) <- func_list
  dt
}


fetch_code <- function(url, github_token = Sys.getenv("GITHUB_PAT")){
  response <- httr::GET(url, httr::add_headers(Authorization = paste0("Bearer ", github_token)))
  if (httr::status_code(response) == 200){
    file_content <- httr::content(response)$content
    function_code <- rawToChar(base64enc::base64decode(file_content))
    return (function_code)
  } else {
    return (NULL)
  }
}  

fetch_url <- function(tree, type){
  if (type == "R") {
    r_files <- (grepl("\\.R$", tree$path, ignore.case = TRUE)) &
      (!grepl("eksperimentell", tree$path, ignore.case = TRUE))
    fil <- tree$url[r_files]
  } else if (type == "python"){
    py_files <- (grepl("\\.py$", tree$path, ignore.case = TRUE)) & 
      (!grepl("eksperimentell", tree$path, ignore.case = TRUE)) &
      (!grepl("__init__", tree$path, ignore.case = TRUE))
    fil <- tree$url[py_files]
  } else if (type == "nb"){
    nb_files <- (grepl("\\.ipynb$", tree$path, ignore.case = TRUE)) & 
      (!grepl("eksperimentell", tree$path, ignore.case = TRUE))
    fil <- tree$url[nb_files]
  } else {
    fil <- NULL
  }
  fil
}  

# Function to check rate limit
check_rate_limit <- function(token = Sys.getenv("GITHUB_PAT")) {
  url <- "https://api.github.com/rate_limit"
  
  response <- httr::GET(url, httr::add_headers(Authorization = paste("token", token)))
  
  # Check if the request was successful
  if (httr::status_code(response) == 200) {
    content <- jsonlite::fromJSON(httr::content(response, "text", encoding = "UTF-8"))
    return(content$rate)
  } else {
    stop("Error: Unable to fetch rate limit status")
  }
}


