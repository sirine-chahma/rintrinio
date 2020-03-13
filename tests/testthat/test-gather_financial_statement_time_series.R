# test functions for gather_financial_time_series() function

library(testthat)

# Sample data for testing
api_key <- 'OjQ0YzljN2E4ODk5YzM1MzVhMTZmNTUwNmE2N2M0NTYz'
ticker <- 'CVX'
statement <- 'income_statement'
year <- c('2017', '2018')
period <- c('Q1','Q3')


test_that("Check the output to be a dataframe", {
  expect_equal(typeof(gather_financial_statement_time_series(api_key, ticker, statement, year, period)), 'list')
})

test_that("Check whether the api_key, ticker, statement, year & period are of type string", {
  expect_error(gather_financial_statement_time_series(Onmshhzy, ticker, statement, year, period))
  expect_error(gather_financial_statement_time_series(api_key, CVX, statement, year, period))
  expect_error(gather_financial_statement_time_series(api_key, ticker, income_statement, year, period))
  expect_error(gather_financial_statement_time_series(api_key, ticker, statement, 2017, period))
  expect_error(gather_financial_statement_time_series(api_key, ticker, statement, year, Q1))
})


test_that("Check whether the year is a character vector and of length 4", {
  expect_error(gather_financial_statement_time_series(api_key, ticker, statement, c(2017, 2018), period))
  expect_error(gather_financial_statement_time_series(api_key, ticker, statement, c(2017), period))
  expect_error(gather_financial_statement_time_series(api_key, ticker, statement, c('205', '2016'), period))
  expect_error(gather_financial_statement_time_series(api_key, ticker, statement, c('20156', '2016'), period))
})

test_that("Check valid entries for statement", {
  expect_error(gather_financial_statement_time_series(api_key, ticker, 'cah_flow_statement', year, period))
})


test_that("Check valid entries for period", {
  expect_error(gather_financial_statement_time_series(api_key, ticker, statement, year, c('Q1','Q5')))
})

