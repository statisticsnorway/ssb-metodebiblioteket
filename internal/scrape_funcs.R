

#' Get url to R, python and ipynb in a repo
#'
#' @param repo Name of the repo (at StatisticsNorway)
#' @param github_token Token so can find internal sites
#'
#' @return list of 3 elements: R files, python files and notebook files.
get_repo_urls <- function(repo, github_token){
  url <- paste0("https://api.github.com/repos/statisticsnorway/", repo, "/contents")
  response <- httr::GET(url, add_headers(Authorization = paste0("Bearer ", github_token)))
  contents <- content(response)
  all_files <- traverse_directory(contents)
  
  r_files <- all_files[grepl("\\.R\\?ref\\=ma", all_files, ignore.case = TRUE)]
  py_files <- all_files[grepl("\\.py\\?ref\\=ma", all_files, ignore.case = TRUE)]
  nb_files <- all_files[grepl("\\.ipynb\\?ref\\=ma", all_files, ignore.case = TRUE)]
  
  list(r_files = r_files, py_files=py_files, nb_files=nb_files)
}


#' Get url to files
#'
#' @param repos Repository
#' @param github_token 
#'
#' @return dataset with urls
#' @export
get_urls <- function(repos, github_token){
  url_data <- data.frame(repo = character(), url = character(), format = character())
  n <- length(repos)
  nr <- 1
  for (r in repos){
    print(paste0("Getting urls for repo nr ", nr, " of ", n, ": " , r))
    u <- get_repo_urls(r, github_token)
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



traverse_directory <- function(contents) {
  #file_names <- character()
  file_url <- character()
  for (item in contents) {
    if (item[["type"]] == "file") {
      #file_names <- c(file_names, item[["name"]])
      file_url <- c(file_url, item[["url"]])
    } else if (item[["type"]] == "dir") {
      # Fetch the contents of the nested folder
      nested_url <- item[["url"]]
      nested_response <- httr::GET(nested_url, add_headers(Authorization = paste0("Bearer ", github_token)))
      nested_contents <- content(nested_response)
      
      # Recursively traverse the nested folder
      nested_files <- traverse_directory(nested_contents)
      #file_names <- c(file_names, nested_files)
      file_url <- c(file_url, nested_files)
    }
  }
  
  return(file_url)
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
check_func <- function(func, url_data, github_token, type = "R"){
  if (type == "R"){
    urls <- url_data[url_data$format %in% c("R", "nb"),]
  }
  if (type == "py"){
    urls <- url_data[url_data$format %in% c("py", "nb"),]
  }
  urls$count <- 0
  counts <- matrix(data=NA, nrow=nrow(urls), length(func))
  for (i in 1:nrow(urls)){
    print(i)
    response <- httr::GET(urls$url[i], add_headers(Authorization = paste0("Bearer ", github_token)))
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
get_repos <- function(org, github_token, type = "all"){
  url <- paste0("https://api.github.com/orgs/", org, "/repos")
  
  repository_names <- character()
  page <- 1
  
  while (TRUE) {
    
    # Send the GET request to retrieve the organization's repositories for the current page
    response <- httr::GET(url, add_headers(Authorization = paste0("Bearer ", github_token)),
                    query = list(per_page = 100, page = page))
    
    # Extract names
    if (http_type(response) == "application/json") {
      repositories <- content(response)
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
