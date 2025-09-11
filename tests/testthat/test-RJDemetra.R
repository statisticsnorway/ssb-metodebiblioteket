
test_that("RJDemetra functions", {

  set.seed(123)
  myseries <- ts(1:(10*12)*0.1 + 10*sin(2*pi*(1:(10*12))/12) + rnorm(10*12,0,3),
                 start=c(2020,1), frequency=12)
  
  # Test for RJDemetra::x13_spec
  spec_b <- x13_spec(spec = "RSA3", transform.function = "None")
  expect_true(inherits(spec_b, "SA_spec"))
  
  # Test for RJDemetra::x13
  b_x13 <- x13(myseries, spec = spec_b)
  expect_equal(b_x13$regarima$arm, 
               c(p = 1, d = 0, q = 1, bp = 0, bd = 1, bq = 1))
  
})
