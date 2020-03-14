# test functions for gather_stock_time_series() function

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
  msg <- "Invalid API Key: please input a valid API key as a string"
  expect_equal(gather_stock_time_series("not an API Key!!!!", ticker), msg)
})

# test that you get an error when you put in an invalid date format for start_date
test_that("Date format error is not working as expected", {
  msg <- "Invalid Date format: date must be a string in the format %Y-%m-%d"
  expect_equal(gather_stock_time_series(api_key, ticker, start_date = "2"), msg)
})

# test that you get an error when you put in an invalid date format for end_date
test_that("Date format error is not working as expected", {
  msg <- "Invalid Date format: date must be a string in the format %Y-%m-%d"
  expect_equal(gather_stock_time_series(api_key, ticker, end_date = "2"), msg)
})

# test that you get an error when you put in an invalid date format for start_date and end_date
test_that("Date format error is not working as expected", {
  msg <- "Invalid Date format: date must be a string in the format %Y-%m-%d"
  expect_equal(gather_stock_time_series(api_key, ticker, start_date = "2", end_date = 123), msg)
})

# test that you get an error when your end date is before your start date
test_that("Date order error is not working as expected", {
  msg <- "Invalid Input: end_date must be later than start_date"
  expect_equal(gather_stock_time_series(api_key, ticker, start_date = "2020-01-30", end_date = "2020-01-01"), msg)
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

# test that by default you get max 100 rows
test_that("allow_max_rows default argument is not working as expected", {
  expect_equal(dim(gather_stock_time_series(api_key, ticker))[1], 100)
})

# test that you get valid output values
test_that("Output shape without any dates is not valid", {
  expect_equal(gather_stock_time_series(api_key, ticker, start_date = "2020-02-15", end_date = "2020-02-23")$open[1], 318.62)
})

# test that you get valid output values
test_that("Output shape without any dates is not valid", {
  expect_equal(gather_stock_time_series(api_key, ticker, start_date = "2020-02-15", end_date = "2020-02-23")$close[3], 323.62)
})
