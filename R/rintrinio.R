library(tidyverse)

# Function that calculates the stock returns

#' Given the tickers, buy-in date, sell-out date, returns the historical prices and profit/loss
#'
#' @param api_key character (sandbox or production) from Intrinio
#' @param ticker character ticker symbols or a vector of ticker symbols
#' @param buy_date character the buy-in date in the format of "%Y-%m-%d", e.g. "2019-12-31"
#' @param sell_date character the sell-out date in the format of "%Y-%m-%d", e.g. "2019-12-31"
#'
#' @return a dataframe that contains the companies, historical prices and corresponding
#' profit/loss
#' @export
#'
#' @examples
#' gather_stock_returns(api_key, ['AAPL', 'AMZON'], "2017-12-31", "2019-03-01")
gather_stock_returns <- function(api_key, ticker, buy_date, sell_date) {
  tibble()
}
