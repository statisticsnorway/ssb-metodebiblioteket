# Tests for functions in simputation package

library(simputation)

test_that("Random hotdeck imputation returns occuring values", {
  dat <- iris
  dat[1:10,1] <- NA
  value_options <- dat$Sepal.Length[4:50]
  impute_values <- impute_rhd(dat, Sepal.Length ~ Species)$Sepal.Length[1:3]
  expect_true(all(impute_values %in% value_options))
})

test_that("KNN imputation returns occuring values in nearest neighbour", {
  dat <- iris[1:10, ]
  dat[1,1] <- NA
  
  # Check for k=3
  value_options <- c(4.6, 5)
  imputed_values = c()
  
  # Run 10 times
  for (i in 1:10){
    imputed_values[i] <- impute_knn(dat, Sepal.Length ~ Sepal.Width, k = 3)[1,1]
  }
  expect_true(all(imputed_values %in% value_options))
  
  # Check for k=4 too
  value_options <- c(4.6, 4.7, 5)
  imputed_values = c()
  for (i in 1:10){
    imputed_values[i] <- impute_knn(dat, Sepal.Length ~ Sepal.Width, k = 4)[1,1]
  }
  expect_true(all(imputed_values %in% value_options))
})

# Bug in impute_pmm still!
# test_that("PMM imputation returns closest values", {
#   dat <- iris[1:10, ]
#   dat[1,1] <- NA
#   
#   form <- Sepal.Length ~ Sepal.Width + Petal.Length
#   fit <- lm(form, data = dat)
#   preds <- predict(fit, dat)
#   
#   differences <- abs(preds - preds[1])
#   ind <- order(differences)[2]
#   expected_value <- dat$Sepal.Length[ind]
#   observed_value <- impute_pmm(dat, form)$Sepal.Length[1]
#   expect_true(expected_value == observed_value)
# })