# New scraping for overview website

#######################################################
#### Setup ####
#######################################################
# Sett opp data folder
dato <- Sys.Date()
filer <- list.files("website")
if (!dato %in% filer){
  dir.create(file.path("./website", dato))
}

# Read in functions
source("internal/scrape_funcs.R")


#######################################################
#### Scraping ####
#######################################################
stat_repos <- get_repos(type = "stat")

dt_all <- find_functions(stat_repos)

# Check how much used
check_rate_limit()


#######################################################
#### Create counts for overview and save ####
#######################################################

names(dt_all)
dt_all$repo_counts <- apply(dt_all, 1, function(row) sum(row !=0))
cond <- !(names(dt_all) %in% c("repo_counts", "repo_used"))
dt_all$repo_used <- apply(dt_all[, cond],
                          1, function(row) {
  paste(names(dt_all)[cond][row != 0], collapse = ", ")
})
View(dt_all[, c("repo_counts", "repo_used")])

function_counts <- dt_all[, c("repo_counts", "repo_used")]
save(function_counts, file = paste0("./website/", dato, "/function_counts.RData"))


