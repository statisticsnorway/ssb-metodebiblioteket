

test_that("CalcInd returns correct value", {
  data(priceData, package = "SSBpris")
  expect_warning(
    ind <- CalcInd(data = priceData, baseVar = "b1", pVar = "p1", groupVar = "varenr", wVar = "weight", 
                   consumVar = "coicop", type = "dutot")
  )
  
  expect_equal(as.numeric(ind[1]), 0.09978126, tolerance = 1E-4)
})



test_that("CalcIndS2 returns correct values", {
    data(priceData, package = "SSBpris")
    ss <- CalcIndS2(data = priceData, baseVar = "b1", pVar = "p1", groupVar = "coicop", 
                          type = "jevons")
    expect_equal(length(ss), 3)
    expect_equal(as.numeric(ss$s2[1]), 0.0019782, tolerance=1E-4)

})

