
test_that("struktur_model returns message for missing y values", {
  data(pop_data, package="struktuR")
  data(sample_data, package="struktuR")
  expect_message(struktur_model(pop_data[, ], sample_data,
                                x = "employees", y = "job_vacancies",
                                id = "id",
                                strata = "industry"))
})


test_that("struktur_model stops when x values are missing", {
  data(pop_data, package="struktuR")
  data(sample_data, package="struktuR")
  pop_data$employees[2] <- NA
  expect_error(struktur_model(pop_data, sample_data,
                              x = "employees", y = "job_vacancies",
                              id = "id",
                              strata = "industry"))
})


test_that("struktur_model returns correct output size and beta estimate", {
  data(pop_data, package="struktuR")
  data(sample_data, package="struktuR")
  suppressMessages(
    test_results <- struktur_model(pop_data, sample_data,
                                   x = "employees", y = "job_vacancies",
                                   id = "id",
                                   strata = "industry")
  )
  expect_equal(nrow(test_results), nrow(pop_data[, ]))
  expect_equal(as.numeric(test_results$job_vacancies_beta[1]), 0.145902357)
})


test_that("struktur_model handles strata with 1 observation", {
  data(pop_data_1obs, package="struktuR")
  data(sample_data_1obs, package="struktuR")
  expect_warning(suppressMessages(
    test_results <- struktur_model(pop_data_1obs, sample_data_1obs,
                                   x = "employees", y = "job_vacancies",
                                   id = "id",
                                   strata = "industry")
  ))
  
  expect_equal(nrow(test_results), nrow(pop_data_1obs[, ]))
  expect_equal(as.numeric(test_results$job_vacancies_beta[10002]), 0.1)
  expect_equal(as.numeric(test_results$job_vacancies_imp[10002]), 7.9)
})

