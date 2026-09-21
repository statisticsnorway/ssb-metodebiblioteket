test_that("pickmdl3 functions exist", {
  expect_true(is.function(add_constraint))
  expect_true(is.function(edit_constraints))
  expect_true(is.function(make_paramfile))
  expect_true(is.function(x13_pickmdl))
  expect_true(is.function(x13_text_frame))
})
