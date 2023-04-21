##-----------------------------##
## Create datasets for testing ##

#### Testdata for Kostra functions ####

# create data frame with 20 rows
set.seed(44)
df <- data.frame(x = numeric(20), y = numeric(20))

# add random numbers between 1 and 10 to x and y values
df$x <- sample(1:10, 20, replace = TRUE)
df$y <- sample(1:10, 20, replace = TRUE)

#Create df with strata 
df_strata <- df 
df_strata$strata <- c(rep(1, 5), rep(2, 5), rep(3, 5), rep(4, 5))

#Create empty df
df_empty <- data.frame(x = numeric(20), y = numeric(20))

save(df, file = "../data/df.RData")
save(df_empty, file = "../data/df_empty.RData")
save(df_strata, file = "../data/df_strata.RData")

df_quartile <- KostraData("testdata")[1:30, 1:5]

df_quartile_strata <- df_quartile
df_quartile_strata$strata <-  c(rep(1, 10), rep(2, 5), rep(3, 10), rep(4, 5))

save(df_quartile, file = "../data/df_quartile.RData")
save(df_quartile_strata, file = "../data/df_quartile_strata.RData")


#### AKU data ####

library(CalibrateSSB)
suppressWarnings(RNGversion("3.5.0"))

set.seed(1234)
aku_testdata <- AkuData(100)
aku_testpop <- AkuData(200)[, 1:7]
aku_testdata$samplingWeights <- sample(10000:100000, NROW(aku_testdata))
aku_testdata$sex <- as.character(aku_testdata$sex)
aku_testpop$age <- as.character(aku_testpop$age)

save(aku_testdata, file = "./data/aku_testdata.RData")
save(aku_testpop, file = "./data/aku_testpop.RData")




