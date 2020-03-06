library(IntrinioSDK)
library(tidyverse)
options(warn=-1)

# Function that gathers a given financial statement for a company for specificed years and quarters

#' Given the ticker, statement, year(s) and period(s) return the complete available financial information from the Intrinio API stock data 
#'
#' @param api_key character (sandbox or production) from Intrinio
#' @param ticker character ticker symbol
#' @param statement character that represents the financial statement that you want to study
#' @param year character vector of the year(s) you want the information for
#' @param period character vector of the period(s) you want the information for
#'
#' @return a dataframe that contains financial statement about the company(ticker) for the specified time frame

#' @export
#' @examples
#' gather_financial_statement_time_series(api_key, 'CVX', 'income_statement', c('2017,'2018'), c('Q1','Q3'))

gather_financial_statement_time_series <- function(api_key, ticker, statement, year, period){
  
  ## Limited free access on intrino provides only Sandbox access
  
  ## Checks
  
  if (typeof(api_key) != "character"){
    stop("The api_key must be a string")
  }
  
  if (typeof(ticker) != "character") {
    stop("The ticker must be a string. For ex. 'CSCO'")
  }
  
  if (typeof(statement) != "character") {
    stop("The statement must be a string. For ex. 'cash_flow_statement'")
  }
  
  if (typeof(year) != "character") {
    stop("The year must be a character vector. For ex. c('2016', '2018')")
  }
  
  for(y in year){
    if(nchar(y) != 4){
      stop("Sorry, year must be a string of 4 digits")
    }
  }
  
  if (typeof(period) != "character") {
    stop("The year must be a character vector. For ex. c('Q1', 'Q3')")
  }
  
  available_statements <- c('income_statement', 'cash_flow_statement', 'balance_sheet_statement')
  
  `%notin%` <- Negate(`%in%`)
  
  if (statement %notin% c('income_statement', 'cash_flow_statement', 'balance_sheet_statement')) {
    stop("Valid entries for statement are 'income_statement', 'cash_flow_statement' or 'balance_sheet_statement'")
  }
  
  ## List of available tickers with sandbox key: 
  ## https://product.intrinio.com/developer-sandbox/coverage/us-fundamentals-financials-metrics-ratios-stock-prices
  
  available_tickers <- c('AAPL', 'AXP', 'BA', 'CAT', 'CSCO', 'CVX', 'DIS', 'DWDP', 'GE', 'GS', 'HD', 'IBM', 'INTC', 'JNJ', 'JPM', 'KO', 'MCD', 'MMM', 'MRK', 'MSFT', 'NKE', 'PFE', 'PG', 'TRV', 'UNH', 'UTX', 'V', 'VZ', 'WMT', 'XOM')
  
  if (ticker %notin% available_tickers) {
    stop("Valid entries for ticker provided in the Readme.md")
  }
  
  available_period <- c('Q1','Q2','Q3','Q4') 
  
  for(q in period){
    if(q %notin% available_period){
      stop("Valid entries for period are a combination Q1/2/3/4. For ex. c('Q1','Q3')")
    }
  }    
  
  client <- IntrinioSDK::ApiClient$new()
  
  ## Configure API key authorization: ApiKeyAuth
  client$configuration$apiKey <- api_key
  
  ## Setup API with client
  FundamentalsApi <- IntrinioSDK::FundamentalsApi$new(client)
  
  ## final dataframe to be joined to this
  my_results = c()
  
  for(i in year) {
    for(j in period) {
      
      ## set key to obtain relevant information
      key <- paste(ticker, statement, i, j, sep='-')
      
      fundamentals <- FundamentalsApi$get_fundamental_standardized_financials(key)
      
      temp_result <- c(c('ticker',ticker), c('statement', statement), c('year', i), c('period', j))  
      
      for (k in 1:(length(fundamentals$content$standardized_financials))) {
        value <- fundamentals$content$standardized_financials[[k]]$value
        data_tag <- fundamentals$content$standardized_financials[[k]]$data_tag$tag
        balance <- fundamentals$content$standardized_financials[[k]]$data_tag$balance          
        
        if (balance == "credit" || is.na(balance)  ){
          value = -value
        }
        
        temp_result <- c(temp_result, c(data_tag, value))
        #print(temp_result)
      }
      
      type <- c()
      fin_value <- c()
      
      for (n in seq(length(temp_result)/2)){
        type <- c(type, temp_result[2*n-1])
        fin_value <- c(fin_value, temp_result[2*n]) 
      }
      
      final_data <- data.frame(type, fin_value)
      
      if(length(my_results)==0){
        my_results <- final_data
      }
      else{
        my_results <- full_join(my_results, final_data, by='type', suffix = c("", "."))
      } 
    }   
    
  }
  return(my_results)
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

gather_financial_statement_company_compare <- function(api_key, ticker, statement, year, period) {
  tibble()
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
