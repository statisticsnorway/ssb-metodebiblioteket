# Run script to create and save all badges

source("internal/badges.R")

dt <- read.csv("data/katalogdata.csv")

cond_r <- grepl("rfunc", dt$keyword)
rpacks <- unique(dt$pack[cond_r])

cond_py <- grepl("python", dt$keyword)
pypacks <- unique(dt$pack[cond_py])

create_badge_pypi("ssb-statstruk")
create_badge_pypi("scikit-learn")
create_badge_pypi("statsmodels")