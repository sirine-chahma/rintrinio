# library(tidyverse) # according to slack, it's suggested not to load the whole tidyverse
library(IntrinioSDK)
library(dplyr)

library(tidyr)
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

gather_financial_statement_company_compare <- function(api_key, ticker, statement, year, period){

  
  statements <-  c('income_statement', 'balance_sheet_statement', 'cash_flow_statement')
  
  #Check if the statement is valid
  if (!(statement %in% statements)){
    stop('the statement must exist')
  }
  
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
  client$configuration$apiKey <- api_key

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
gather_stock_time_series <- function(api_key, ticker, start_date='', end_date='') {
  
  # set up options
  if (start_date != '' & end_date != '') {
    opts <- list(start_date = as.Date(start_date), end_date = as.Date(end_date), page_size = 10000)
  }
  else if (start_date != '') {
    opts <- list(start_date = as.Date(start_date), page_size = 10000)
  }
  else if (end_date != '') {
    opts <- list(end_date = as.Date(end_date), page_size = 10000)
  }
  else {
    opts <- list(page_size = 10000)
  }
  
  # throw an error if the API Key is Invalid
  api_error <- try({
    client <- IntrinioSDK::ApiClient$new()
    client$configuration$apiKey <- api_key
    SecurityApi <- IntrinioSDK::SecurityApi$new(client)
    result <- SecurityApi$get_security_stock_prices(ticker, opts)$content$stock_prices_data_frame
    
  }, silent=T)
  if(is.null(result)) {
    return("Incorrect API Key - please input a valid API key as a string")
  }
  
  return(result)


# Function that calculates the stock returns

#' Given the tickers, buy-in date, sell-out date, returns the historical prices and profit/loss
#'
#' @param api_key character (sandbox or production) from Intrinio
#' @param ticker character ticker symbols or a vector of ticker symbols
#' @param buy_date character the buy-in date in the format of "%Y-%m-%d", e.g. "2019-12-31"
#' If the input date is not a trading day, it will be automatically changed to the next nearest trading day.
#' @param sell_date character the sell-out date in the format of "%Y-%m-%d", e.g. "2019-12-31"
#' If the input date is not a trading day, it will be automatically changed to the last nearest trading day.
#'
#' @return a dataframe that contains the companies, historical prices and corresponding
#' profit/loss
#' @export
#'
#' @examples
#' gather_stock_returns(api_key, c('AAPL', 'CSCO'), "2017-12-31", "2019-03-01")

gather_stock_returns <- function(api_key, ticker, buy_date, sell_date) {

  # test whether the input dates are in the right format
  t <- try({buy_date <- as.Date(buy_date)
            sell_date <- as.Date(sell_date)}, silent=T)
  if("try-error" %in% class(t)) {
      return("Invalid Date format - please input the date as a string with format %Y-%m-%d")
  }
  if (buy_date >= sell_date){
      return("Invalid Input: `sell_date` is earlier than `buy_date`.")
  }

  client <- IntrinioSDK::ApiClient$new()
  # Configure API key authorization: ApiKeyAuth
  client$configuration$apiKey <- api_key

  # Setup API with client
  SecurityApi <- IntrinioSDK::SecurityApi$new(client)

  # convert date type
  buy_date <- as.Date(buy_date)
  buy_date_upper <- buy_date + 10
  sell_date <- as.Date(sell_date)
  sell_date_lower <- sell_date - 10

  # test if the API Key works
  t <- try({opts <- list(start_date=buy_date, end_date=sell_date)
            x <- SecurityApi$get_security_stock_prices('AAPL', opts)$content$stock_prices_data_frame$adj_close}, silent=T)
  if(is.null(x)) {
      return("Incorrect API Key - please input a valid API key as a string")
  }

  # create vectors to record the results
  rcd_buy_price <- c()
  rcd_sell_price <- c()
  rcd_rtn <- c()

  for (x in ticker){

    opts <- list(start_date=buy_date, end_date=buy_date_upper)
    buy_date <- tail(SecurityApi$get_security_stock_prices(x, opts)$content$stock_prices_data_frame$date, 1)
    buy_price <- tail(SecurityApi$get_security_stock_prices(x, opts)$content$stock_prices_data_frame$adj_close, 1)

    opts <- list(start_date=sell_date_lower, end_date=sell_date)
    sell_date <- head(SecurityApi$get_security_stock_prices(x, opts)$content$stock_prices_data_frame$date, 1)
    sell_price <- head(SecurityApi$get_security_stock_prices(x, opts)$content$stock_prices_data_frame$adj_close, 1)

    rnt <- ((sell_price - buy_price) / buy_price) * 100

    rcd_buy_price <- c(rcd_buy_price, round(buy_price, 4))
    rcd_sell_price <- c(rcd_sell_price, round(sell_price, 4))
    rcd_rtn <- c(rcd_rtn, round(rnt, 2))

  }

  result <- tibble('Stock' = ticker,
          'Buy date' = buy_date,
          'Buy price' = rcd_buy_price,
          'Sell date' = sell_date,
          'Sell price' = rcd_sell_price,
          'Return (%)' = rcd_rtn
        )

  return(result)
}
