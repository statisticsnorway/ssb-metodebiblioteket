
# Call in data in package
data("df")
data("df_empty")
data("df_strata")
data("df_quartile")
data("df_quartile_strata")

#### AggrSml2NumVar ####

#Save the result of the functions in different results
result_n <- AggrSml2NumVar(data = df, xVar = "x", yVar = "y", identiske = FALSE)
result_empty <- AggrSml2NumVar(data = df_empty, xVar = "x", yVar = "y", identiske = FALSE)
result_strata <- AggrSml2NumVar(data = df_strata, xVar = "x", yVar = "y", strataVar = "strata", identiske = FALSE)

test_that("Tests that Sumx and Sumy works for AggrSml2NumVar", {
  #Test without strata
  expect_equal(result_n$Sumx, 71)
  expect_equal(result_n$Sumy, 112)
  
  #Test empty
  expect_equal(result_empty$Sumx, 0)
  expect_equal(result_empty$Sumy, 0)
  
  #Test with strata
  expect_identical(result_strata$Sumx[[1]], as.integer(24))
  expect_identical(result_strata$Sumy[[1]], as.integer(23))
  
  expect_identical(result_strata$Sumx, as.integer(c(24, 15, 18, 14)))
  expect_identical(result_strata$Sumy, as.integer(c(23, 28, 27, 34)))
})

test_that("Tests that SumxProsAvTotx and SumxProsAvToty works for AggrSml2NumVar", {
  #test without strata
  expect_equal(result_n$SumxProsAvTotx, 100)
  expect_equal(result_n$SumyProsAvToty, 100)
  
  #test empty
  expect_equal(result_empty$SumxProsAvTotx, NaN)
  expect_equal(result_empty$SumyProsAvToty, NaN)
  
  #test with strata, sum should be 100 
  expect_lte(sum(result_strata$SumxProsAvTotx), 100+0.01)
  expect_lte(sum(result_strata$SumyProsAvToty), 100+0.01)
  expect_gte(sum(result_strata$SumxProsAvTotx), 100-0.01)
  expect_gte(sum(result_strata$SumyProsAvToty), 100-0.01)
  
  #expect_error(AggrSml2NumVar(data = 3, xVar = "x", yVar = "y", identiske = FALSE), "invalid data")
})

test_that("Tests that Diff and AbsDiff works for AggrSml2NumVar", {
  #tests without strata
  expect_equal(result_n$Diff, 41)
  expect_equal(result_n$AbsDiff, 41)
  
  #tests for empty df
  expect_equal(result_empty$Diff, 0)
  expect_equal(result_empty$AbsDiff, 0)
  
  #tests with strata
  expect_equal(sum(result_strata$Diff), 41)
  expect_equal(sum(result_strata$AbsDiff), 43)
  expect_equal(result_strata$Diff[[1]], as.integer(-1))
  expect_equal(result_strata$AbsDiff[[1]], as.integer(1))
})

test_that("Tests that DiffProsAvSumx and AbsDiffProsAvSumx works for AggrSml2NumVar", {
  
  #tests without strata
  expect_lte(result_n$DiffProsAvSumx, 57.74+0.01)
  expect_gte(result_n$DiffProsAvSumx, 57.74-0.1)
  expect_lte(result_n$AbsDiffProsAvSumx, 57.74+0.01)
  expect_gte(result_n$AbsDiffProsAvSumx, 57.74-0.01)
  
  #tests for empty df
  expect_equal(result_empty$DiffProsAvSumx, NaN)
  expect_equal(result_empty$AbsDiffProsAvSumx, NaN)
  
  #tests with strata
  expect_lte(result_strata$DiffProsAvSumx[[1]], -4.1666+0.01)
  expect_gte(result_strata$DiffProsAvSumx[[1]], -4.1666-0.01)
  expect_lte(result_strata$AbsDiffProsAvSumx[[1]], 4.1666+0.01)
  expect_gte(result_strata$AbsDiffProsAvSumx[[1]], 4.1666-0.01)
  
})

test_that("Tests that DiffProsAvTotx and AbsDiffProsAvTotx works for AggrSml2NumVar", {
  
  #tests without strata
  expect_lte(result_n$DiffProsAvTotx, 57.74+0.01)
  expect_gte(result_n$DiffProsAvTotx, 57.74-0.1)
  expect_lte(result_n$AbsDiffProsAvTotx, 57.74+0.01)
  expect_gte(result_n$AbsDiffProsAvTotx, 57.74-0.01)
  
  #tests for empty df
  expect_equal(result_empty$DiffProsAvTotx, NaN)
  expect_equal(result_empty$AbsDiffProsAvTotx, NaN)
  
  #tests with strata
  expect_lte(result_strata$DiffProsAvTotx[[1]], -1.408+0.01)
  expect_gte(result_strata$DiffProsAvTotx[[1]], -1.408-0.01)
  expect_lte(result_strata$AbsDiffProsAvTotx[[1]], 1.408+0.01)
  expect_gte(result_strata$AbsDiffProsAvTotx[[1]], 1.408-0.01)
})


#### Quartile ####
#Save the result of the functions in different results
q_result_x1Y1 <- Quartile(data = df_quartile, 
                          id = "Region", 
                          x1 = "areal_130_eier_2015", y1 = "areal_130_leier_2015")

q_result_x1Y1_x2y2 <- Quartile(data = df_quartile, 
                               id = "Region", 
                               x1 = "areal_130_eier_2015", y1 = "areal_130_leier_2015",
                               x2 = "areal_130_eier_2014", y2 = "areal_130_leier_2014")

q_result_x1Y1_x2y2_pKL_pKU <- Quartile(data = df_quartile, 
                                       id = "Region", 
                                       x1 = "areal_130_eier_2015", y1 = "areal_130_leier_2015", pKL = 2, pKU = 2)

q_result_strata <- Quartile(data = df_quartile_strata, 
                            id = "Region", 
                            x1 = "areal_130_eier_2015", y1 = "areal_130_leier_2015",
                            x2 = "areal_130_eier_2014", y2 = "areal_130_leier_2014", 
                            strataName = "strata")

#Only units with both x1 and y1 not missing and greater than zero should be included
test_that("Tests that the correct units are included in Quartile", {
  #Test without strata
  region_list <- c(3956, 25306, 4867, 5252, 5648, 2516, 4877, 14450, 28015, 16708)
  expect_true(all(q_result_x1Y1$x1 %in% region_list)& all(region_list %in% q_result_x1Y1$x1))
  
  #Test with strata
  region_list <- c(3956, 25306, 4867, 5252, 5648, 2516, 4877, 14450, 28015, 16708)
  expect_true(all(q_result_strata$x1 %in% region_list)& all(region_list %in% q_result_strata$x1))
})

test_that("Tests the ratio between x1 and y1, and x2 and y2 for Quartile", {
  #Test without strata (same with and without)
  expected_values_x1y1 <- c(0.47292, 6.26386, 24.33500, 8.31013, 3.17482, 2.82379, 
                            3.81911, 15.42156, 9.95558, 6.04924)
  ratios_x1y1 <- q_result_x1Y1_x2y2$ratio
  for (i in 1:length(ratios_x1y1)){
    expect_equal(ratios_x1y1[i], expected_values_x1y1[i], tolerance = 0.001)
  }
  
  expected_values_x2y2 <- c(0.00000, 8.83898, NA, 7.54589, 3.30063, 2.82379,
                            3.81911, 15.42156, 9.95025, 8.52449)
  
  ratios_x2y2 <- q_result_x1Y1_x2y2$ratio2
  for (i in 1:length(ratios_x2y2)){
    expect_equal(ratios_x2y2[i], expected_values_x2y2[i], tolerance = 0.001)
  }
})


test_that("Tests the ratio between the sum of x1 and y1, and x2 and y2 for Quartile", {
  #Test without strata
  expected_ratioAll <- 4.70911929
  expected_ratioAll2 <- 3.69672
  expect_equal(q_result_x1Y1_x2y2$ratioAll[1], expected_ratioAll, tolerance = 0.001)
  expect_equal(q_result_x1Y1_x2y2$ratioAll2[1], expected_ratioAll2, tolerance = 0.001)
})
test_that("Tests the ratio aggregated over the stratum for Quartile", {
  
  #Test with strata
  ratioStr_strata1 <- q_result_strata[q_result_strata$strata == 1, "ratioStr"]
  ratioStr_strata2 <- q_result_strata[q_result_strata$strata == 2, "ratioStr"]
  ratioStr_strata3 <- q_result_strata[q_result_strata$strata == 3, "ratioStr"]
  ratioStr_strata4 <- q_result_strata[q_result_strata$strata == 4, "ratioStr"]
  
  expected_ratioStr_str1 <- 2.70758
  expected_ratioStr_str2 <- 8.31013
  expected_ratioStr_str3 <- 7.21044
  expected_ratioStr_str4 <- 6.04924
  
  expect_equal(ratioStr_strata1[1], expected_ratioStr_str1, tolerance = 0.001)
  expect_equal(ratioStr_strata2[1], expected_ratioStr_str2, tolerance = 0.001)
  expect_equal(ratioStr_strata3[1], expected_ratioStr_str3, tolerance = 0.001)
  expect_equal(ratioStr_strata4[1], expected_ratioStr_str4, tolerance = 0.001)
  
  ratioStr2_strata1 <- q_result_strata[q_result_strata$strata == 1, "ratioStr2"]
  ratioStr2_strata2 <- q_result_strata[q_result_strata$strata == 2, "ratioStr2"]
  ratioStr2_strata3 <- q_result_strata[q_result_strata$strata == 3, "ratioStr2"]
  ratioStr2_strata4 <- q_result_strata[q_result_strata$strata == 4, "ratioStr2"]
  
  expected_ratioStr2_str1 <- 1.62212
  expected_ratioStr2_str2 <- 7.54589
  expected_ratioStr2_str3 <- 6.62408
  expected_ratioStr2_str4 <- 8.52449
  
  expect_equal(ratioStr2_strata1[1], expected_ratioStr2_str1, tolerance = 0.001)
  expect_equal(ratioStr2_strata2[1], expected_ratioStr2_str2, tolerance = 0.001)
  expect_equal(ratioStr2_strata3[1], expected_ratioStr2_str3, tolerance = 0.001)
  expect_equal(ratioStr2_strata4[1], expected_ratioStr2_str4, tolerance = 0.001)
})

#test_that("Tests the lower and upper limit of the ratio", {
  #Test without strata
  #Test with strata
#  
#})

# test_that("Tests if outlier calculation is correct", {
#   #Test without strata
#   #Test with strata
#   
# })



#### OutlierRegressionMicro ####


#### Rank2NumVar ####


df_n <- df_quartile_strata[,-c(4, 5)]

# uten strata
r_result <- Rank2NumVar(data = df_n, idVar = "Region", xVar = "areal_130_eier_2014", yVar = "areal_130_eier_2015",
                        strataVar = NULL, antall = 30, grense = NULL, identiske = FALSE)

# med strata
r_result_strata <- Rank2NumVar(data = df_n, idVar = "Region", xVar = "areal_130_eier_2014", yVar = "areal_130_eier_2015",
                               strataVar = "strata", antall = 5, identiske = FALSE)

# med identiske = TRUE
r_result_id <- Rank2NumVar(data = df_n, idVar = "Region", xVar = "areal_130_eier_2014", yVar = "areal_130_eier_2015",
                           strataVar = "strata", antall = 4, grense = NULL, identiske = TRUE)

# med grense (overstyrer antall)
r_result_grense <- Rank2NumVar(data = df_n, idVar = "Region", xVar = "areal_130_eier_2014", yVar = "areal_130_eier_2015",
                               strataVar = "strata", antall = 5, grense = 10000, identiske = FALSE)

test_that("Tests that 'identiske' gives only values on both x and y for Rank2NumVar", {
  #Test without antall
  r_result_identiske <- Rank2NumVar(data = df_n, idVar = "Region", xVar = "areal_130_eier_2014", yVar = "areal_130_eier_2015",
                                    strataVar = NULL, antall = 30, grense = NULL, identiske = TRUE)
  region_list <- c(16299, 25306, 3179, 1205, 5400, 970, 0, 4867, 2000, 0, 
                   4640, 2650, 4769, 942, 10562, 3345, 1250, 3082, 7626, 
                   2516, 4877, 4950, 14450, 28000, 16708, 7950, 1532, 
                   2554, 5705)
  
  expect_true(all(r_result_identiske$x %in% region_list) & 
                all(region_list %in% r_result_identiske$x))
  
  #Test with strata antall - sjekk dette!
  #ant_r_result_identiske <- Rank2NumVar(data = df_n, idVar = "Region", xVar = "areal_130_eier_2014", yVar = "areal_130_eier_2015",
  #                                      strataVar = "strata", antall = 5, grense = NULL, identiske = TRUE)
  #expected_str1 <- c(0, 16299, 25306, 3179, 1205, 5400, 970, 4867, 2000)
  
  #values_str1 <- ant_r_result_identiske[ant_r_result_identiske$strata == 1, "x"]
  #expect_true(all(values_str1 %in% expected_str1) & 
  #              all(expected_str1 %in% values_str1))
})

test_that("Tests the ratio between x and y, 'forh' in function Rank2NumVar", {
  #Test without strata
  expect_equal(r_result$forh[1], 1.00054, tolerance = 0.0001)
  #Test with strata
  expect_equal(r_result_strata$forh[1], 1.000, tolerance = 0.0001)
  
  #Test zero values 
  expect_equal(r_result_strata$forh[1], 1.000, tolerance = 0.0001)
  tmp <- r_result$forh[r_result$x == 0]
  expect_true(all(sapply(tmp, function(x) is.infinite(x) || is.nan(x) || is.na(x))))
})

# Note: the rank calculation of xRank does not work for strata 1, 
# something similar to what happens with 'identiske', see implementation
# Rank2SumVar

#test_that("Tests the xRank and yRank", {
  #Test without strata
  
  #Test with strata
#})

# test_that("Tests the rank of xProsAvSumx and yProsAvSumy", {
#   #Test without strata
#   #Test with strata
#   
# })
# 
# 

#test_that("Tests 'antall' and 'grense'", {
  #Test without strata
  #Test with strata
  
#})
# 
# 
# test_that("Tests identiske", {
#   #Test without strata
#   #Test with strata
#   
# })


#### Diff2NumVar ####
df_new <- df_quartile_strata[,-c(4, 5)]

# lager en z-variabel
df_new$z <- df_new$areal_130_eier_2015
df_new$z[4*(1:7)] <- df_new$areal_130_eier_2014[2*(1:7)]
df_new$z[10*(1:3)] <- 1.2 * df_new$areal_130_eier_2015[10*(1:3)]
df_new$z[10*(1:3) - 5] <- 0.7 * df_new$areal_130_eier_2015[10*(1:3) - 5]

# lager en kommentarvariabel
df_new$kommentar <- ifelse(df_new$areal_130_eier_2015 == df_new$z, "ikke kontrollert",
                       "godkjent")

# uten strata
d_result1 <- Diff2NumVar(data = df_new, idVar = "Region", xVar = "areal_130_eier_2014", yVar = "areal_130_eier_2015",
                         strataVar = NULL, antall = 5, grense = NULL, zVar = NULL, kommentarVar = NULL)

# med z og kommentar
d_result_str <- Diff2NumVar(data = df_new, idVar = "Region", xVar = "areal_130_eier_2014", yVar = "areal_130_eier_2015",
                            strataVar = "strata", antall = 10, grense = NULL, zVar = "z", kommentarVar = "kommentar")

test_that("Tests that correct values are included", {
  #only units with value on both variables should be included
  d_result <- Diff2NumVar(data = df_new, idVar = "Region", xVar = "areal_130_eier_2014", yVar = "areal_130_eier_2015",
                          strataVar = NULL, antall = 30, grense = NULL, zVar = NULL, kommentarVar = NULL)
  
  region_list <- c(0, 16299, 25306, 3179, 1205, 5400, 970, 4867, 2000, 0, 
                   4640, 2650, 4769, 942, 10562, 3345, 1250, 3082, 7626, 2516, 
                   4877, 4950, 14450, 28000, 16708, 7950, 1532, 2554, 5705)
  
  expect_true(all(d_result$x %in% region_list) & 
                all(region_list %in% d_result$x))
})

test_that("Tests that 'Forh', ratio between x and y works for Diff2NumVar", {
  expected_values_yx <- c(0.5347, Inf, 0.6818, 0.7362, 0.8179)
  ratios_yx <- d_result1$Forh
  
  for (i in 1:length(ratios_yx)){
    expect_equal(ratios_yx[i], expected_values_yx[i], tolerance = 0.001)
  }
})

test_that("Tests that 'Diff', difference between x and y works for Diff2NumVar", {
  expected_values_Diff <- c(-4914, 3956, -1575, -813, -579)
  diff_yx <- d_result1$Diff
  
  for (i in 1:length(diff_yx)){
    expect_equal(diff_yx[i], expected_values_Diff[i], tolerance = 0.001)
  }
})

test_that("Tests that 'AbsDiff' works for Diff2NumVar", {
  expected_values_Diff <- c(-4914, 3956, -1575, -813, -579)
  expected_values_AbsDiff <- lapply(expected_values_Diff, abs)
  expected_values_AbsDiff <- unlist(expected_values_AbsDiff)
  
  absDiff_yx <- d_result1$AbsDiff
  
  for (i in 1:length(absDiff_yx)){
    expect_equal(absDiff_yx[i], expected_values_AbsDiff[i], tolerance = 0.001)
  }
  
})

test_that("Tests that 'DiffProsAvx' works for Diff2NumVar", {
  expect_equal(d_result1$DiffProsAvx[1], -46.52528, tolerance = 0.001)
  expect_equal(d_result1$DiffProsAvx[2], Inf)
})

test_that("Tests that 'DiffProsAvSumx' and 'DiffProsAvTotx' works for Diff2NumVar",{
  #DiffProsAvSumx
  #without strata
  expect_equal(d_result1$DiffProsAvSumx[1], -2.62312, tolerance = 0.001)
  #with strata
  expect_equal(d_result_str$DiffProsAvSumx[1], 6.67950, tolerance = 0.001)
  
  #DiffProsAvTotx
  #without strata
  expect_equal(d_result1$DiffProsAvTotx[1], d_result1$DiffProsAvSumx[1], tolerance = 0.001)
  expect_equal(d_result1$DiffProsAvTotx[4], d_result1$DiffProsAvSumx[4], tolerance = 0.001)
  #with strata
  expect_equal(d_result_str$DiffProsAvTotx[1], 2.11174, tolerance = 0.001)
})

test_that("Tests that 'SumDiffProsAvSumx' and 'SumDiffProsAvTotx' works for Diff2NumVar",{
  #SumDiffProsAvSumx, with strata
  expect_equal(d_result1$SumDiffProsAvSumx[1], -1.80910, tolerance = 0.001)
  #SumDiffProsAvSumx, without strata
  expect_equal(d_result_str$SumDiffProsAvSumx[1], 5.68163, tolerance = 0.001)
  
  #SumDiffProsAvTotx, with strata
  expect_equal(d_result1$SumDiffProsAvTotx[1], d_result1$SumDiffProsAvSumx[1], tolerance = 0.001)
  expect_equal(d_result1$SumDiffProsAvTotx[4], d_result1$SumDiffProsAvSumx[4], tolerance = 0.001)
  
  #SumDiffProsAvTotx, without strata
  expect_equal(d_result_str$SumDiffProsAvTotx[1], 1.79626, tolerance = 0.001)
})



test_that("Tests that 'EdEndring' works for Diff2NumVar",{
  expect_equal(d_result_str$y[1] - d_result_str$z[1], 0, tolerance = 0.001)
})


test_that("Tests that input 'antall' and 'grense' works for Diff2NumVar",{
  #specifying 'grense'
  d_result_grense_1 <- Diff2NumVar(data = df_new, idVar = "Region", xVar = "areal_130_eier_2014", yVar = "areal_130_eier_2015",
                                   strataVar = "strata", antall = 30, grense = 200, zVar = "z", kommentarVar = "kommentar")
  diff_list <- d_result_grense_1$AbsDiff
  expect_true(all(diff_list > 200))
  # 'grense' overules 'antall'
  d_result_grense_2 <- Diff2NumVar(data = df_new, idVar = "Region", xVar = "areal_130_eier_2014", yVar = "areal_130_eier_2015",
                                   strataVar = "strata", antall = 2, grense = 200, zVar = "z", kommentarVar = "kommentar")
  expect_true(all(d_result_grense_2$id %in% d_result_grense_1$id))
  #specifying 'antall'
  d_result_antall <- Diff2NumVar(data = df_new, idVar = "Region", xVar = "areal_130_eier_2014", yVar = "areal_130_eier_2015",
                                 strataVar = "strata", antall = 2, grense = NULL, zVar = "z", kommentarVar = "kommentar")
  antall <- list()
  for (i in 1:4){
    antall[i] <- sum(d_result_antall$strata == i) 
  }
  expect_true(all(antall == 2))
})


#### Hb ####
#df_Hb <- df_quartile_strata

#result_hb1 <- Hb(data = df_Hb, id = "Region", x1 = "areal_130_eier_2015", x2 = "areal_130_eier_2014")

#result_hb2 <- Hb(data = df_Hb, id = "Region", 
#                 x1 = "areal_130_eier_2015", 
#                 x2 = "areal_130_eier_2014",
#                 strataName = "strata")

#result_hb3 <- Hb(data = df_Hb, id = "Region", 
#                 x1 = "areal_130_eier_2015", 
#                 x2 = "areal_130_eier_2014",
#                 pU = 0.5, pA = 0.05, pC = 20, 
#                 strataName = "strata")

#test_that("x1 = x2 values included only if less than 50%", {
#  
#})
# 
# test_that("x1, x2 not missing and greater than 0", {
#   
# })
# 
# test_that("Tests that maxX and ratio works", {
#   
# })
# 
# test_that("Tests that lowerLimit and upperLimit of ratio works", {
#   
# })
# 
# test_that("Test that outlier indication works", {
#   
# })



#### ThError ####
df_n <- df_quartile_strata[,-c(4, 5)]

df_n$areal_130_eier_2015[c(1, 4, 5, 10, 15)] <- 1000 * df_n$areal_130_eier_2015[c(1, 4, 5, 10, 15)]

result1 <- ThError(data = df_n, id = "Region", x1 = "areal_130_eier_2015", x2 = "areal_130_eier_2014")
result2 <- ThError(data = df_n, id = "Region", x1 = "areal_130_eier_2015", x2 = "areal_130_eier_2014",
                   ll = -2, ul = 2)

test_that("Test that all ids are included in output from ThError", {
  region_list <- df_n$Region
  expect_true(all(result1$id %in% region_list))
})

test_that("Test that 'outlier' indication is correct for ThError", {
  region_id <- as.character(factor(df_n$Region[c(1, 4, 5, 10, 15)]))
  region_id <- as.integer(region_id)
  outlier_r <- as.list(result1$outlier[result1$id %in% region_id])
  outlier_r <- unlist(outlier_r[!is.na(outlier_r)])
  #for(i in range(1:length(outlier_r))){
  #  print(outlier_r[i])
  #  #expect_identical(result_row[i], 1)
  #}
  result_not_in_outlier <- as.list(result1$outlier[!(result1$id %in% region_id)])
  result_not_in_outlier <- unlist(result_not_in_outlier[!is.na(result_not_in_outlier)])
  expect_identical(result_not_in_outlier, rep(0, length(result_not_in_outlier)))
})

#test_that("Test that 'diffLog10' is correct", {
#  
#})

# test_that("Test that 'lowerLimit' and 'upperLimit' is correct", {
#   
# })


