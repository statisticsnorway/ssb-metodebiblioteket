
test_that("EasyData works", {
  expect_identical(dim(EasyData("z1")), c(32L, 3L))
})


test_that("ProtectTable and  ProtectKostra works", {
  z1 <- EasyData("z1") 
  a <- ProtectTableData(z1, c("region","hovedint"), "ant",  method="SIMPLEHEURISTIC", IncProgress = NULL)
  
  z1w <- EasyData("z1w") 
  b <- ProtectTableData(z1w, 1, 2:5, method="SIMPLEHEURISTIC", IncProgress = NULL) 
  
  expect_equal(as.numeric(unlist(b[1:8, 12:15])), a$suppressed[1:32])
  
  # capture.output to avoid printing "....."
  capture.output({d <-  ProtectKostra(z1w,idVar="region", freqVar=2:5)})
  
  expect_equal(b[, c(1, 12:16)], d, ignore_attr = TRUE)
})

