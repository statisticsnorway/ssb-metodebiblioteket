# Unittests for ReGenesees package
library(ReGenesees)
data(data.examples)

test_that("e.svydesign returns a valid survey design object", {
  des <- e.svydesign(
    data = example,
    ids = ~towcod + famcod,
    strata = ~stratum,
    weights = ~weight
  )
  
  # Check that the object is of the expected class
  expect_s3_class(des, "survey.design") 
  
  # Check that it contains the expected variables
  expect_true("variables" %in% names(des))
  expect_true(is.data.frame(des$variables))
  
  # Check that the number of rows matches the input data
  expect_equal(nrow(des$variables), nrow(example))
  
  # Check that strata and ids are present
  expect_true(!is.null(des$strata))
  expect_true(!is.null(des$cluster))
})


test_that("fill.template correctly fills population totals", {
  data(sbs)
  sbsdes <- e.svydesign(data = sbs, ids = ~id, strata = ~strata, weights = ~weight, fpc = ~fpc)
  pop_template <- pop.template(sbsdes, calmodel = ~area - 1)
  
  filled_pop <- fill.template(universe = sbs.frame, template = pop_template)
  
  expect_s3_class(filled_pop, "data.frame")
  expect_equal(dim(filled_pop), dim(pop_template))
})

test_that("e.calibrate returns a valid calibrated design object", {
  data(sbs)
  sbsdes <- e.svydesign(data = sbs, ids = ~id, strata = ~strata, weights = ~weight, fpc = ~fpc)
  pop_template <- pop.template(sbsdes, calmodel = ~area - 1)
  filled_pop <- fill.template(universe = sbs.frame, template = pop_template)
  
  sbscal <- e.calibrate(sbsdes, filled_pop, sigma2 = ~emp.num, bounds = c(-Inf, Inf))
  
  expect_s3_class(sbscal, class(sbsdes))
  expect_equal(nrow(sbscal$variables), nrow(sbsdes$variables))
  expect_true(all(is.finite(weights(sbscal))))
})


test_that("svystatL computes a valid linearized total estimate", {
  data(data.examples)
  des <- e.svydesign(data = example, ids = ~towcod + famcod, strata = ~SUPERSTRATUM, weights = ~weight)
  
  result <- svystatL(des, expression(1e6 * (income / ones)), vartype = "cvpct")
  
  expect_s3_class(result, "data.frame")
  expect_named(result, c("Complex", "CV%"))
  expect_true(is.numeric(result[[1]]))
  expect_true(is.finite(result[[1]]))
  expect_true(is.numeric(result[["CV%"]]))
})

test_that("svystatTM computes a valid total mean estimate", {
  data(data.examples)
  des <- e.svydesign(data = example, ids = ~towcod + famcod, strata = ~SUPERSTRATUM, weights = ~weight)
  
  result <- svystatTM(des, ~income, vartype = "cvpct")
  
  expect_s3_class(result, "data.frame")
  expect_named(result, c("Total", "CV%"))
  expect_true(is.numeric(result$Total))
  expect_true(is.finite(result$Total))
  expect_true(is.numeric(result[["CV%"]]))
})


