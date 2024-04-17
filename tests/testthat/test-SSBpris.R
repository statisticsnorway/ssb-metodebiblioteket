# Testing of price index calculations

test_that("CalcInd returns correct value in consumVar groups", {
  data(priceData)
  suppressWarnings(
    ind <- CalcInd(data = priceData, baseVar = "b1", pVar = "p1", groupVar = "varenr", wVar = "weight", 
                   consumVar = "nace3", type = "dutot")
  )
  expect_equal(as.numeric(ind[1]), 1.028245, tolerance = 1E-4)
})


test_that("CalcInd throws a warning if weights must be adjusted, otherwise no warning", {
  priceData <- priceData[priceData$varenr %in% c(1,2),]
  expect_warning(
    CalcInd(data = priceData, baseVar = "b1", pVar = "p1", groupVar = "varenr", wVar = "weight", 
            consumVar = "coicop", type = "dutot")
  )
  priceData$weight <- c(rep(0.5, 6), rep(0.5, 7))
  expect_silent(
    CalcInd(data = priceData, baseVar = "b1", pVar = "p1", groupVar = "varenr", wVar = "weight", 
            consumVar = "coicop", type = "dutot")
  )
})


test_that("CalcInd throws warning for missing weight values", {
  data(priceData)
  priceData <- priceData[priceData$varenr %in% c(1,2),]
  priceData$weight <- c(rep(0.5, 6), rep(0.5, 7))
  priceData[1, "weight"] <- NA
  expect_warning(ind <- CalcInd(data = priceData, baseVar = "b1", pVar = "p1", groupVar = "varenr", wVar = "weight", 
                                consumVar = "coicop", type = "dutot"),
                 "wVar has missing or invalid values"
  )
  
  # check that it returns the value though
  expect_equal(as.numeric(ind), 1.014, tolerance = 0.001, ignore_attr=F)
})

test_that("CalcInd returns vector of length, equal to consumVar", {
  data(priceData)
  expect_warning(ind <- CalcInd(data = priceData, baseVar = "b1", pVar = "p1", groupVar = "varenr", wVar = "weight", 
                                consumVar = "coicop", type = "dutot"),
                 "Elementary group weights did not add to one"
  )
  expect_equal(length(ind), 10)
  
  # check levels works if only a subset of data is run
  priceData$coicop <- factor(priceData$coicop)
  priceData <- priceData[priceData$coicop %in% c(1,2),]
  expect_warning(ind <- CalcInd(data = priceData, baseVar = "b1", pVar = "p1", groupVar = "varenr", wVar = "weight", 
                                consumVar = "coicop", type = "dutot"),
                 "Elementary group weights did not add to one"
  )
  expect_equal(length(ind), 2)
})
