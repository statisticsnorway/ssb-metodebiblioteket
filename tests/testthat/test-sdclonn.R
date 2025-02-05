
test_that("sdclonn  works", {     # As the first test in the sdclonn package
  a <- sdclonn::sdclonn_data("syntetisk_5000")
  out2 <- sdclonn::sdc_lonn(a, 
                            between = ~yrke3 + (yrke2 + yrke1) * sektor3,  
                            within = ~arb_heldeltid,
                            k1 = 80, k2 =85)
  expect_equal(sum(out2[["prikket_manedslonn_nedre_kvartil"]], na.rm = TRUE), 5691893.115)
})
