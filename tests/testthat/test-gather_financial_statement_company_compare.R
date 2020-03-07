# test functions for gather_financial_statement_company_compare() function

library(tidyverse)
library(IntrinioSDK)
library(testthat)

# helper data
api_key <- 'OmEzNGY3MGEwMDIwZGM5Y2UxNDZhNzUzMTgzYTJiNWI2'
ticker <- c("AAPL", 'CSCO')
typeof(api_key)
statement <- "income_statement"
year <- "2018"
period <- "Q1"

#Test that it returns an error if the names in the tickers are not valid
test_that("The names in the ticker are not vaid", {
  expect_error(gather_financial_statement_company_compare('AAAA', ticker, statement, year, period))
})

# test that return type is a dataframe
test_that("The default return type is not a dataframe", {
  expect_equal(typeof(gather_financial_statement_company_compare(api_key, ticker, statement, year, period)), 'list')
})


# test that the api_key is a string
test_that("The api_key is not a string", {
  expect_error(gather_financial_statement_company_compare(123, ticker, statement, year, period))
})

# test that the ticker is a string
test_that("The ticker is not a string", {
  expect_error(gather_financial_statement_company_compare(api_key, 123, statement, year, period))
})

# test that the statement is a string
test_that("The statement is not a string", {
  expect_error(gather_financial_statement_company_compare(api_key, ticker, 123, year, period))
})

# test that the year is a string
test_that("The year is not a string", {
  expect_error(gather_financial_statement_company_compare(api_key, ticker, statement, 123, period))
})

# test that the period is a string
test_that("The period is not a string", {
  expect_error(gather_financial_statement_company_compare(api_key, ticker, statement, year, 123))
})

# test that the output has 3 columns when we put 2 tickers as the input
test_that("The output doesn't have 3 columns", {
  expect_equal(ncol(gather_financial_statement_company_compare(api_key, ticker, statement, year, period)), 3)
})
