
test_that("pickmdl functions", {

  myseries <- pickmdl::pickmdl_data("myseries")
  spec_a <- RJDemetra::x13_spec(spec = "RSA3", transform.function = "Log")
  
  # Test for pickmdl::konstruksjon
  kalfak <- konstruksjon(forste_ar = 2025, siste_ar = 2030)
  expect_equal(kalfak$m_paske$mn, c(4, 4, 3, 4, 4, 4))
  
  # Test for pickmdl::x13_automdl
  a_automdl <- x13_automdl(myseries, spec_a)
  expect_equal(a_automdl$regarima$arm, 
               c(p = 2, d = 1, q = 1, bp = 0, bd = 1, bq = 1))
  
  # Test for pickmdl::x13_pickmdl
  a_pickmdl <- x13_pickmdl(myseries, spec_a, )
  expect_equal(comment(a_pickmdl), 
               c(ok = "TRUE", ok_final = "TRUE", mdl_nr = "3"))
  
  # Test for pickmdl::x13_both
  a_both <- x13_both(myseries, spec = "RSA3", transform.function = "Log")
  expect_equal(a_both, a_pickmdl)
  
  # Test for pickmdl::x13_text_frame
  s2 <- cbind(Oslo = myseries, Kongsvinger = myseries + 10)
  tf <- data.frame(name = c("Oslo", "Kongsvinger"), 
                   automdl.enabled = c("FALSE", "TRUE"))
  a_text_frame <- x13_text_frame(tf, series = "s2", 
                                 spec = "RSA3", transform.function = "Log")
  expect_equal(a_text_frame[["Oslo"]], a_pickmdl)           
  
})
