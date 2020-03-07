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
#'   for that time and those tickers as a dataframe
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

gather_financial_statement_company_compare <- function(api_key, ticker, statement, year, period){
  
  #check if the api_key is a string
  if (typeof(api_key) != "character"){
    stop("the api_key must be a string")
  }
  
  #check if the ticker is a string
  if (typeof(ticker) != "character") {
    stop("the ticker must be a string")
  }
  
  #check if the statement is a string
  if (typeof(statement) != "character") {
    stop("the statement must be a string")
  }
  
  #check if the year is a string
  if (typeof(year) != "character") {
    stop("the year must be a string")
  }
  
  #check if the period is a string
  if (typeof(period) != "character") {
    stop("the period must be a string")
  }
  
  
  client <- IntrinioSDK::ApiClient$new()
  
  # Configure API key authorization: ApiKeyAuth
  client$configuration$apiKey <- key
  
  # Setup API with client
  FundamentalsApi <- IntrinioSDK::FundamentalsApi$new(client)
  
  #final dataframe
  result = c()
  
  for (comp in seq(length(ticker))){
    
    #set the id
    id <- paste(ticker[comp], statement, year, period, sep='-')
    
    response <- FundamentalsApi$get_fundamental_standardized_financials(id)
    
    #create a vector for each information
    my_list <- c(c('ticker',ticker[comp]), c('statement', statement), c('year', year), c('period', period))
    
    for (i in 1:(length(response$content$standardized_financials))){
      value <- response$content$standardized_financials[[i]]$value
      data_tag <- response$content$standardized_financials[[i]]$data_tag$tag
      balance <- response$content$standardized_financials[[i]]$data_tag$balance
      
      if (is.na(balance) || balance=="credit"){
        value = -value
      }
      #my_list contains all the tags and the corresponding values
      my_list <- c(my_list, c(data_tag, value))
    }
    #name will be a vector of the tags
    name <- c()
    #value contains the values of those tags
    value <- c()
    
    for (j in seq(length(my_list)/2)){
      name <- c(name, my_list[2*j-1])
      value <- c(value, my_list[2*j])
    }
    #create the final dataframe
    data <- data.frame(name, value)
    if(length(result)==0){
      result <- data
    }
    else{
      result <- full_join(result, data, by='name')
    }
  }
  result
}


# Function that gathers historical stock price information

#' Given the ticker, start date, and end date, return from the Intrinio API stock data 
#' for that time frame in either a dictionary or a pandas dataframe format.
#'
#' @param api_key character (sandbox or production) from Intrinio
#' @param ticker character the ticker symbol you would like to get stock data for
#' @param start_date character optional earliest date in the format of "%Y-%m-%d", e.g. "2019-12-31" to get data for
#' @param end_date character optional most recent date in the format of "%Y-%m-%d", e.g. "2019-12-31" to get data for
#'
#' @return a dataframe that contains stock data for the specific timefram
#' @export
#'
#' @examples
#' gather_stock_time_series(api_key, 'AAPL', "2017-12-31", "2019-03-01")
gather_stock_time_series <- function(api_key, ticker, start_date, end_date) {
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
