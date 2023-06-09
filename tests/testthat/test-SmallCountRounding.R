
test_that("SmallCountData works", {
  expect_identical(dim(SmallCountRounding::SmallCountData("e6")), c(6L, 4L))
})

test_that("PLSroundingPublish works", {
  z <- SmallCountRounding::SmallCountData("e6")
  a <- PLSroundingPublish(z[, -2], "freq", hierarchies = SmallCountRounding::SmallCountData("eHrc"))
  b <- PLSroundingPublish(z, "freq", formula = ~eu * year + geo * year)
  expect_identical(duplicated(rbind(a,b)), c(rep(FALSE, 18), rep(TRUE, 18)))
})
