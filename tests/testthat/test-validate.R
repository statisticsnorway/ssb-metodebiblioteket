# Test functions in validate package
data(cars)

#### validator ####
rules <- validator(speed >= 0, 
                   dist >= 0, 
                   speed/dist <= 1.5, 
                   cor(speed, dist) >= 0.2)

test_that("validator() returns an object of class 'validator'", {
  expect_true(inherits(rules, "validator"))
  expect_true(is(rules, "validator"))
})

test_that("Validation rules work on cars dataset", {
  out <- confront(cars, rules)
  
  # Check that all rules are evaluated
  expect_equal(length(out), 4)
  
  # Check two are failing
  expect_equal(sum(summary(out)$fails), 2)
})
