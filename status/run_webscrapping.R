# Run scraping to create numbers for the status report

library(lubridate)
source("internal/scrape_funcs.R")


# Sett opp data folder
dato <- lubridate::today()
filer <- list.files("status/")
if (!dato %in% filer){
  dir.create(file.path("./status", dato))
}
print(paste("Dato:", dato))

# Get function list
met <- read.csv("data/katalogdata.csv")
funcs_all <- met$func
funcs_r <- funcs_all[substr(met$keyword, 1, 5) == "rfunc"]
funcs_py <- funcs_all[substr(met$keyword, 1, 6) == "python"]

# Get repo list
org <- "statisticsnorway"

repo_stat <- get_repos(org, github_token = params$pwd, type = "stat")
repo_stat_urls <- get_urls(repo_stat, github_token = params$pwd)

repo_kurs <- get_repos(org, github_token = params$pwd, type = "stat")
repo_kurs_urls <- get_urls(repo_stat, github_token = params$pwd)

tab <- check_func(
  func = c("LmImpute", "struktur_model", "Hb", "SupressSmallCounts"), 
  url_data=repo_urls, 
  github_token=params$pwd, 
  type="R")
row.names(tab) <- NULL
mask <- apply(tab[,2:4], MARGIN=1, FUN=sum) > 0
kableExtra::kbl(tab[mask,])