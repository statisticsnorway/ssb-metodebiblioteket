# Create badge urls for pacakges

library(httr)
library(jsonlite)

# Check authentication
if (Sys.getenv("GITHUB_PAT") == ""){
  Sys.setenv(GITHUB_PAT = getPass::getPass("PAT: "))
}

get_time_diff <- function(release_date){
  today <- Sys.Date()
  diff <- as.numeric(difftime(today, release_date, units = "days"))
  if (diff < 2) {
    last_update <- "a%20day%20ago"
  } else if (diff < 30) {
    last_update <- paste0(diff, "%20days%20ago")
  } else if (diff < 60) {
    last_update <- "a%20month%20ago"
  } else if (diff < 365) {
    last_update <- paste0(round(diff / 30), "%20months%20ago")
  } else if (diff < 600){
    last_update <- "a%20year%20ago"
  } else {
    last_update <- paste0(round(diff /365), "%20years%20ago")
  }
  last_update
}

SSB_GET <- function(url, json=T){
  url_response <- httr::GET(url,
                            httr::add_headers(
                              Authorization = paste0("Bearer ", Sys.getenv("GITHUB_PAT")))
  )
  if (httr::status_code(url_response) == 200) {
    if (json){
      content_data <- jsonlite::fromJSON(
        httr::content(url_response, as = "text", encoding = "UTF-8"))
      
    }else {
      content_data <- 
        httr::content(url_response, as = "text", encoding = "UTF-8")
    }
  } else {
    content_data <- httr::status_code(url_response)
  }
  content_data
}

get_github_rversion <- function(repo, branch){
  desc_url <- paste0("https://raw.githubusercontent.com/statisticsnorway/", repo, "/",branch,"/DESCRIPTION")
  desc_content <- SSB_GET(desc_url, json=F)
  version_line <- grep("^Version:", strsplit(desc_content, "\n")[[1]], value = TRUE)
  if (length(version_line) > 0) {
    version <- sub("^Version:\\s+", "", version_line)
  } else {
    version <- "No version found"
  }
  version
}


get_github_pyversion <- function(repo, branch){
  desc_url <- paste0("https://api.github.com/repos/statisticsnorway/", repo, "/releases")
  release_content <- SSB_GET(desc_url)
  
  latest_tag <- release_content$tag_name[!test$draft][1]
  latest_date <- release_content$published_at[!test$draft][1]
  
  c(latest_tag, latest_date)
}


# Function to get the last commit date of a repository
get_last_commit_date <- function(repo) {
  
  url <- paste0("https://api.github.com/repos/statisticsnorway/", repo)
  repo_info <- SSB_GET(url)
  branch <- repo_info$default_branch
  last_commit_date <- repo_info$updated_at
  
  c(get_time_diff(last_commit_date), branch)
  
}

#' Title
#'
#' @param pkg 
#' @param package_info 
#'
#' @return
#' @export
#'
#' @examples
create_badge_cran <- function(pkg, package_info){
  version <- package_info[package_info$Package == pkg, "Version"]
  release_date <- as.Date(package_info[package_info$Package == pkg, "Published"])
  base <- "https://img.shields.io/badge/CRAN-"
  last_update <- get_time_diff(release_date)
  col <- ifelse(grepl("years", last_update), "yellow", "green")
  badge <- paste0(base, version, "%20--%20", last_update, "-", col, ".svg")
  badge
}

#package_info <- tools::CRAN_package_db()
#create_badge_cran("klassR", package_info)


#' Title
#'
#' @param repo 
#'
#' @return
#' @export
#'
#' @examples
create_badge_rgithub <- function(repo){
  date_branch <- get_last_commit_date(repo)
  version <- get_github_rversion(repo, date_branch[2])
  published <- date_branch[1]
  
  base <- "https://img.shields.io/badge/github-"
  col <- ifelse(grepl("years", published), "yellow", "green")
  badge <- paste0(base, version, "%20--%20", published, "-", col, ".svg")
  badge
}
#create_badge_rgithub("ssb-klassr")


#' Title
#'
#' @param repo 
#'
#' @return
#' @export
#'
#' @examples
create_badge_pygithub <- function(repo){
  v_date <- get_github_pyversion(repo)
  version <- v_date[1]
  published <- get_time_diff(v_date[2])
  
  base <- "https://img.shields.io/badge/github-"
  col <- ifelse(grepl("years", published), "yellow", "green")
  badge <- paste0(base, version, "%20--%20", published, "-", col, ".svg")
  badge
}
#create_badge_pygithub("ssb-statstruk")

pkg <- "ssb-statstruk"
get_pypi_version <- function(pkg){

    # Construct the API URL for the package
    pypi_url <- paste0("https://pypi.org/pypi/", pkg, "/json")
    
    # Make a GET request to the PyPI API endpoint
    pypi_data <- SSB_GET(pypi_url)
    
    # Extract the latest version
    latest_version <- pypi_data$info$version
      
    # Extract the publish date of the latest version
    release_dates <- pypi_data$releases[[latest_version]]
    latest_release_date <- release_dates$upload_time[nrow(release_dates)]
      
    # Return the version and release date as a list
    c(latest_version, latest_release_date)
  }
  
create_badge_pypi <- function(pkg){
  try(
    v_date <- get_pypi_version(pkg),
    silent=T
  )
  if (inherits(v_date, "try-error")){
    pkg <- strsplit(pkg, "[.]")[1]
    try(
      v_date <- get_pypi_version(pkg)
    )
  }
  c(v_date, pkg)
}
create_badge_pypi(pkg)


