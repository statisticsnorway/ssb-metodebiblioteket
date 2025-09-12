


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



test_that("quantile_weighted", {
  qw <- quantile_weighted(c(1:10, 5:22), probs = c(0:5)/5, weights = 3 + (1:28))
  expect_equal(as.vector(qw), c(1, 8, 11, 15.5, 19, 22))
})



test_that("model_aggregate", {
  z <- SSBtools::SSBtoolsData("sprt_emp_withEU")
  z$age[z$age == "Y15-29"] <- "young"
  z$age[z$age == "Y30-64"] <- "old"
  names(z)[names(z) == "ths_per"] <- "ths"
  z$y <- 1:18
  
  my_range <- function(x) c(min = min(x), max = max(x))
  
  out <- model_aggregate(z, 
                         formula = ~age:year + geo, 
                         sum_vars = c("y", "ths"), 
                         fun_vars = c(sum = "ths", mean = "y", med = "y", ra = "ths"), 
                         fun = c(sum = sum, mean = mean, med = median, ra = my_range),
                         verbose = FALSE)
  
  expect_equal(range(SSBtools::formula_selection(out, ~geo)$ths_ra.min), c(1.5, 63.4)) 
})



test_that("tables_by_formulas", {
  
  out <- tables_by_formulas(SSBtools::SSBtoolsData("magnitude1"),
                            table_fun = model_aggregate, 
                            table_formulas = list(table_1 = ~ region * sector2, 
                                                  table_2 = ~ sector4 - 1), 
                            substitute_vars = list(region = c("geo", "eu")), 
                            collapse_vars = list(sector = c("sector2", "sector4")), 
                            fun_vars = "value",
                            fun = c(mean = mean, median = median, n = length), 
                            term_labels = TRUE, 
                            verbose = FALSE)
  
  expect_equal(apply(out[c("median", "mean", "n")], 2, sum), 
               c(median = 281.9, mean = 397.48375, n = 140)) 
})





