
test_that("GaussSuppression functions", {
  
  printInc <- FALSE
  
  set.seed(123)
  d2 <- SSBtools::SSBtoolsData("d2")
  d2$v <- round(rnorm(nrow(d2))^2, 1)
  d2$family_id <- round(2 * as.integer(factor(d2$region)) + runif(nrow(d2)))
  
  a <- SuppressSmallCounts(data = d2, maxN = 4, freqVar = "freq", dimVar = 1:4, printInc = printInc)
  expect_equal(sum(a$suppressed), 29)
  
  
  a <- SuppressKDisclosure(data = d2, freqVar = "freq", dimVar = 1:4, printInc = printInc)
  expect_equal(sum(a$suppressed), 14)
  
  
  a <- SuppressDominantCells(data = d2, maxN = 2, numVar = "v", contributorVar = "family_id", 
                             dimVar = c("region","county", "k_group"), n = c(1, 2), k = c(65, 85), printInc = printInc)
  expect_equal(sum(a$suppressed), 16)
  
  a <- SuppressFewContributors(data = d2, maxN = 2, numVar = "v", contributorVar = "family_id", 
                               dimVar = c("region", "county", "k_group"), printInc = printInc)
  expect_equal(sum(a$suppressed), 15)
  
  
  a <- GaussSuppressDec(d2, dimVar = 1:4, freqVar = "freq", maxN = 4, printInc = printInc)
  
  b <- SuppressionFromDecimals(a[a$isInner, ], hierarchies = SSBtools::FindDimLists(d2[1:4]), 
                               freqVar = "freq", decVar = "freqDec", printInc = printInc)
  
  a <- GaussSuppressionFromData(d2, dimVar = 1:4, freqVar = "freq", maxN = 4, printInc = printInc)
  
  expect_equal(a[c(1:3, 5)], b[c(1:3, 6)])
  
})
