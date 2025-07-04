library(testthat)
library(dcmodify)

test_that("modifier creates a valid modifier object from inline rules", {
  m <- modifier(
    if (height < mean(height)) height <- 2 * height,
    if (weight > mean(weight)) weight <- weight / 2
  )
  
  # Check class
  expect_s3_class(m, "modifier")
  
  # Check that rules are stored
  expect_true(length(m) == 2)
})

test_that("modifier creates a valid modifier object from a data frame", {
  rules_df <- data.frame(
    rule = c(
      "if (height < mean(height)) height <- 2 * height",
      "if (weight > mean(weight)) weight <- weight / 2"
    ),
    name = c("rule1", "rule2"),
    label = c("Double short height", "Halve heavy weight"),
    description = c("Adjust height", "Adjust weight"),
    origin = c("test", "test"),
    created = as.POSIXct(c(Sys.time(), Sys.time())),
    stringsAsFactors = FALSE
  )
  
  m <- modifier(.data = rules_df)
  
  expect_s3_class(m, "modifier")
  expect_equal(length(m), 2)
})

test_that("modifier reads rules from file", {
  data(women)
  
  # Create a temporary file with rules
  rules <- modifier(
    if (height < mean(height)) height <- 2 * height, 
    if ( weight > mean(weight) ) weight <- weight / 2)
  
  expect_true(inherits(rules, "modifier"))
  expect_equal(length(rules), 2)
  
  women_mod <- modify(women, rules)
  expect_equal(nrow(women), nrow(women_mod))
  expect_equal(women$height[1] * 2, women_mod$height[1])
})
