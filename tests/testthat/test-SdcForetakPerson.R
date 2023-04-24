
test_that("SdcForetakPerson", {
  prikkeVarA <- c("arb_fylke", "ARB_ARBKOMM", "nar8", "sektor")
  prikkeVarB <- c("arb_fylke", "ARB_ARBKOMM", "nar17")
  
  z <- SdcForetakPerson::SdcData("syssel27")
  
  # capture.output to avoid printing to console 
  capture.output({a <- SdcForetakPerson(z, between = prikkeVarA)})
  
  expect_equal(sum(a$roundedSuppressed[!is.na(a$roundedSuppressed)]), 177)
})


