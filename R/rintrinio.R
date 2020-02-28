library(tidyverse)

# Function that gathers a given financial statement for a company for specificed years and quarters

#' Given the tickers, statement, year and period returns all the financial information from the Intrinio API stock data 
#'
#' @param api_key character (sandbox or production) from Intrinio
#' @param ticker ticker symbol
#' @param statement character that represents the financial statement that you want to study
#' @param year vector of the years (as characters) you want the information for
#' @param period vector of the periods (characters) you want the information from
#'
#' @return a dataframe that contains information about the given statement for a given ticker for the specified years

#' @export
#' @examples
#' gather_financial_statement_time_series(api_key, 'AAPL', 'income_statement', ['2018,'2019'], ['Q1'])

gather_financial_statement_time_series <- function(api_key, ticker, statement, year, period){
  tibble()
}


# Function that gathers a given statement at a specific time for different companies
#' Given the tickers, statement, year and period returns all the information from the Intrinio API fundamental reported financials
#'   for that time and those tickers in either a dictionary or a pandas dataframe format.
#'
#' @param api_key character (sandbox or production) from Intrinio
#' @param ticker vector of characters ticker symbols
#' @param statement character that represents the statement that you want to study
#' @param year character that represents the year you want the information from
#' @param period character that represents the period you want the information from
#'
#' @return a dataframe that contains information about the given statement for the given tickers at the given time
#' @export
#' @examples
#' gather_financial_statement_company_compare(api_key, ['AAPL', 'CSCO'], 'income_statement', '2019', 'Q1')

gather_financial_statement_company_compare <- function(api_key, ticker, statement, year, period) {
  tibble()
}


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
