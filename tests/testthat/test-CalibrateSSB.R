

Csum <- function(a){
  x <- as.numeric(as.matrix(a))
  x <- x[!is.na(x)]
  c(length(x),sum(x),sum(x^2))
}


test_that("CalibrateSSB examples", {
  data(aku_testdata)
  data(aku_testpop)
  
  #### CalibrateSSB Examples
  
  # Calibration using "survey"
  a <- CalibrateSSB(aku_testdata, calmodel = "~ sex*age",
                    partition = c("year","q"),  # calibrate within quarter
                    popData = aku_testpop, y = c("unemployed","workforce"),
                    by = c("year","q")) # Estimate within quarter
  expect_identical(Csum(a$popTotals),c(64,20096,32956616))
  expect_equal(Csum(a$w),c(800,1600,4428.729572165))
  expect_equal(Csum(a$estTM),c(32, 17414.751745, 32658559.6096))
  
  
  expect_identical(a$popTotals, CalibrateSSB(aku_testdata, calmodel = "~ sex*age",
                                             partition = c("year","q"),  # calibrate within quarter
                                             popData = aku_testpop, y = c("unemployed","workforce"),
                                             by = c("year","q"), onlyTotals = TRUE))
  
  
  # Calibration, no package, popTotals as input
  b <- CalibrateSSB(aku_testdata, popTotals=a$popTotals, calmodel="~ sex*age",
                    partition = c("year","q"), usePackage = "none", y = c("unemployed","workforce"))
  
  expect_identical(a$popTotals, b$popTotals)
  expect_equal(a$w, b$w)
  expect_equal(colSums(a$estTM[,3:4]), colSums(b$estTM))
  
  
  expect_identical(a$popTotals, CalibrateSSB(aku_testdata, popTotals=a$popTotals, calmodel="~ sex*age",
                                             partition = c("year","q"), usePackage = "none", 
                                             y = c("unemployed","workforce"), onlyTotals = TRUE))
  
  
  #### PanelEstimation Examples
  
  bWide = CalibrateSSB::WideFromCalibrate(b,CalibrateSSB::CrossStrata(aku_testdata[,c("year","q")]),aku_testdata$id)
  
  # Define linear combination matrix
  lc = rbind(CalibrateSSB::LagDiff(8,4),CalibrateSSB::PeriodDiff(8,4))
  rownames(lc) = c("diffQ1","diffQ2","diffQ3","diffQ4","diffYearMean")
  colnames(lc) = colnames(head(bWide$y[[1]]))
  
  # Unemployed: Totals and linear combinations
  d1=PanelEstimation(bWide,"unemployed",linComb=lc)  
  
  expect_equal(range(d1$wTot), c(200,200))
  expect_equal(Csum(c(d1$estimates, d1$linCombs, d1$varEstimates, d1$varLinCombs)),
               c(26, 113.4170829057, 1674.9380089581))
  
  d=PanelEstimation(bWide,numerator="unemployed",denominator="workforce",linComb=lc)
  
  expect_equal(Csum(unlist(d)), c(86, 3493.652535091372, 535118.167577150976))
  
  expect_warning(b2 <- CalibrateSSB(aku_testdata,popData=aku_testpop,calmodel="~ edu*sex + sex*age",
                                    partition=c("year","q"), y=c("unemployed","workforce"),
                                    leverageOutput=TRUE))
  
  
  expect_equal(Csum(log(unlist(b2)+1)), c(7352, 2206.516235572093, 3617.600635213678))
  
  
  b2Wide = CalibrateSSB::WideFromCalibrate(b2,CalibrateSSB::CrossStrata(aku_testdata[,c("year","q")]),aku_testdata$id,extra=aku_testdata$famid)
  d2 = PanelEstimation(b2Wide,"unemployed",linComb=lc,group=1,estType = "robustModelGroup")
  
  expect_equal(Csum(unlist(d2)), c(42, 3329.254745316503, 642035.689654916176)) 
  
  g=PanelEstimation(bWide,numerator="unemployed",denominator="workforce",
                    linComb= CalibrateSSB::LagDiff(2),linComb0=CalibrateSSB::Period(8,4))
  
  expect_equal(Csum(unlist(g)), c(50, 3208.179712767641, 522114.947009256517))
  
  expect_equal(Csum(c(g$varEstimates, g$varLinCombs)),c(3, 2.554084342077243e-04, 2.771624841133405e-08))
  
})

