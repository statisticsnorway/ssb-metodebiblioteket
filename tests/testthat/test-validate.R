# Test functions in validate package
data(cars)

#### validator ####
rules <- validate::validator(speed >= 0, 
                   dist >= 0, 
                   speed/dist <= 1.5, 
                   cor(speed, dist) >= 0.2)

test_that("validator() returns an object of class 'validator'", {
  expect_true(inherits(rules, "validator"))
  expect_true(is(rules, "validator"))
})

test_that("Validation rules work on cars dataset", {
  out <- validate::confront(cars, rules)
  
  # Check that all rules are evaluated
  expect_equal(length(out), 4)
  
  # Check two are failing
  correct <- validate::values(out)[[1]]
  expect_equal(sum(!correct), 2)
})
