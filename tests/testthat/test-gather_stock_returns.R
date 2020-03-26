# test file for `gather_stock_returns` function

library(testthat)

# helper data
api_key <- 'OjhlMjhjNTBmY2IyMWJiMWE0MTExYjQwNWZmZTVkZWM1'
ticker <- c('AAPL','CSCO')
buy_date <- '2011-01-01'
sell_date <- '2019-12-10'
rtn_appl <- 555.38
rtn_csco <- 176.01

test_that("Stock returns should be correctly calculated", {
    result <- gather_stock_returns(api_key, ticker, buy_date = buy_date, sell_date = sell_date)
    expect_equal(result['Return....'][[1]][1], rtn_appl)
    expect_equal(result['Return....'][[1]][2], rtn_csco)
    expect_equal(dim(result)[1], 2)
    expect_equal(dim(result)[2], 6)
})

test_that("Check the validation of api_key", {
    msg <- "Invalid API Key: please input a valid API key as a string"
    expect_error(gather_stock_returns('abc', 'AAPL', buy_date = buy_date, sell_date = sell_date), msg)
})


test_that("Check if the function correctly handles the input dates in wrong formats", {
    msg <- "Invalid Date format: date must be a string in the format %Y-%m-%d"
    expect_error(gather_stock_returns(api_key, 'AAPL', '2018', sell_date), msg)
})


test_that("Make sell_date earlier to buy date. See if the function handles this exception.", {
    msg <- "Invalid Input: sell_date must be later than buy_date"
    expect_error(gather_stock_returns(api_key, 'AAPL', buy_date='2019-01-01', sell_date='2017-01-01'), msg)
})

