
library(rvest)
library(httr)
library(base64enc)
library(stringr)

source("R/scrape_funcs.R")

org <- "statisticsnorway"
github_token <- getPass::getPass()

repo_stat <- get_repos(org, github_token, type = "stat")
repo_urls <- get_urls(repo_stat, github_token)

system.time(tab <- check_func(c("LmImpute", "struktur_model", "Hb" ,"SupressSmallCOunts"), repo_urls, github_token, type = "R"))
mask <- apply(tab[,2:4], MARGIN=1, FUN=sum) > 0
View(tab[mask,])
