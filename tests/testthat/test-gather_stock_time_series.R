# test functions for gather_stock_time_series() function

library(tidyverse)
library(IntrinioSDK)
library(testthat)

# helper data
api_key <- 'OjhlMjhjNTBmY2IyMWJiMWE0MTExYjQwNWZmZTVkZWM1'
ticker <- 'AAPL'
start_date <- '2011-01-01' 
end_date <- '2019-12-10'

# test that return type is a dataframe
test_that("The default return type is not a dataframe", {
  expect_equal(typeof(gather_stock_time_series(api_key, ticker)), 'list')
})

# test that you get an error when you put in an incorrect API key
test_that("API Error is not working as expected", {
  msg <- "Incorrect API Key - please input a valid API key as a string"
  expect_equal(gather_stock_time_series("not an API Key!!!!", ticker), msg)
})

# test that you get a valid output shape when you put in no start date
test_that("Output shape without a start date is not valid", {
  expect_gt(dim(gather_stock_time_series(api_key, ticker, end_date = "2020-02-15"))[1], 0)
})

# test that you get a valid output shape when you put in no end date
test_that("Output shape without an end date is not valid", {
  expect_gt(dim(gather_stock_time_series(api_key, ticker, start_date = "2020-02-15"))[1], 0)
})

# test that you get a valid output shape when you don't put in a start or end date
test_that("Output shape without any dates is not valid", {
  expect_gt(dim(gather_stock_time_series(api_key, ticker))[1], 0)
})

# test that you get valid output values
test_that("Output shape without any dates is not valid", {
  expect_equal(gather_stock_time_series(api_key, ticker, start_date = "2020-02-15", end_date = "2020-02-23")$open[1], 318.62)
})

# test that you get valid output values
test_that("Output shape without any dates is not valid", {
  expect_equal(gather_stock_time_series(api_key, ticker, start_date = "2020-02-15", end_date = "2020-02-23")$close[3], 323.62)
})