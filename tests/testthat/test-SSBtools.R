


test_that("HierarchyCompute works", {
  # Data and hierarchies used in the examples
  x <- SSBtools::SSBtoolsData("sprt_emp")  # Employment in sport in thousand persons from Eurostat database
  geoHier <- SSBtools::SSBtoolsData("sprt_emp_geoHier")
  ageHier <- SSBtools::SSBtoolsData("sprt_emp_ageHier")
  
  # Two hierarchies and year as rowFactor
  a <- HierarchyCompute(x, list(age = ageHier, geo = geoHier, year = "rowFactor"), "ths_per")
  
  # Same result with year as colFactor (but columns ordered differently)
  b <- HierarchyCompute(x, list(age = ageHier, geo = geoHier, year = "colFactor"), "ths_per")
  
  # Avoid numerical precision problems 
  a$ths_per=round(a$ths_per, 1)
  b$ths_per=round(b$ths_per, 1)
  
  expect_identical(duplicated(rbind(a,b)), c(rep(FALSE, 9), rep(TRUE, 9)))
})