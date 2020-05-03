
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rintrinio

<!-- badges: start -->

[![R build
status](https://github.com/UBC-MDS/rintrinio/workflows/R-CMD-check/badge.svg)](https://github.com/UBC-MDS/rintrinio/actions)
[![codecov](https://codecov.io/gh/UBC-MDS/rintrinio/branch/master/graph/badge.svg)](https://codecov.io/gh/UBC-MDS/rintrinio)
<!-- badges: end -->

R (R Core Team 2019) package converts Intrinio (Swagger Codegen
community 2020) objects and lists to dataframes.

The vignette can be found [here](https://ubc-mds.github.io/rintrinio/).

## The Project

This project has been created as part of [UBC’s Master of Data Science
Program](https://masterdatascience.ubc.ca/). Information about the
contributors can be found [here](CONTRIBUTORS.md). The Code of Conduct
can be found [here](CONDUCT.md). The collaboration expectations
regarding use of Github Flow can be found [here](CONTRIBUTING.md).

If you were to search the web for “historical stock data”, or “financial
statement data”, the results you would come across would be a variety of
web applications (such as Google Finance), and maybe some PDFs of
financial statements. This is fair, as there is a massive volume of
stock data, and financial statements require lots of discretion
(including standards followed - US companies may choose between
reporting under IFRS and US GAAP). [Intrinio](https://intrinio.com/)
offers solutions to this problem with an API platform that can easily be
used to extract data and perform further analysis on it.

Intrinio is an excellent source to get data into the R environment to
analyse data, but a problem persists that the data can’t be directly
analysed from Intrinio objects. That is where rintrinio comes in. This
package will offer a variety of functions that allow users to seamlessly
transform Intrinio objects into dataframes. This will enable users of
the data to make the most of Intrinio’s reliable and easy-to-use API
platform, as well as the analysis capabilities that are available in R’s
environment.

## rintrinio in the R Ecosystem

R is an object-oriented programming language, which has allowed
contributors of packages to make complex data types appear simple, and
overall make packages easy for users to use. R’s native dataframe object
is extremely popular and widely accepted in the R ecosystem. Intrinio’s
API platform for R actually has a function that is supposed to return
the results as a dataframe object, but it is actually a list that is
returned. This package will transform Intrinio objects into dataframes
that will make this data ready for the end user to use.

## Installation

You can install the current version of rintrinio from github with:

``` r
library(devtools)
devtools::install_github("UBC-MDS/rintrinio")
```

## Coverage

To get the line coverage, run the following from the R Console:

``` r
if(!require(covr)) { install.packages("covr") }
library("covr")
covr::report()
```

### Dependencies

#### Getting an API Key

Before using any functions included in this package, you must sign up
for an appropriate [Intrinio account](https://intrinio.com/). Once you
have signed up for the appropriate account, you can find your API key
(which is a required argument in all functions) by doing the following:

1.  In the top right corner, select `My Account`
2.  In the left hand menu, select `API KEYS`
3.  Copy your relevant API Key. Note that this is unique to you and
    should not be shared.

If you are using a free version of Intrinio for educational purposes,
please note that you will only have access to the [Developer
Sandbox](https://product.intrinio.com/developer-sandbox) so use that API
key in functions.

Note that the API key must be of type `character` when it is used in our
functions. Hence, don’t forget to use quotation marks when you use your
API key.

#### Installing Intrinio R SDK

Please note that the Intrinio R SDK is not available via CRAN. To
install, follow these steps, as outlined in the [Intrinio R
Documentation](https://docs.intrinio.com/documentation/r). Note that
Intrinio R SDK should be installed prior to installing rintrinio.

In an R console, install `devtools` if it is not already installed:

``` r
if(!require(devtools)) { install.packages("devtools") }
```

Install Intrinio SDK from Github:

``` r
library(devtools)
devtools::install_github("intrinio/r-sdk")
```

#### Program and Package Dependencies

R version 3.6.1 and R packages:

  - knitr==1.26 (Xie 2020)
  - tidyverse==1.2.1 (Wickham 2017)
  - IntrinioSDK==0.1.0 (Swagger Codegen community 2020)
  - testthat==2.3.1 (Wickham 2011)

## Functions

1.  **gather\_financial\_statement\_time\_series()**: This function
    takes in a single stock ticker symbol, the statement, the year, and
    a vector of various periods to compare. It returns a data frame of
    the information in the selected statement, for a time-series
    analysis of the company specified.
2.  **gather\_financial\_statement\_company\_compare()**: This function
    takes in a vector containing the tickers of the companies we want to
    compare, the statement we want to focus on, and the year and the
    period of the year we want to study. It returns a dataframe of the
    information in the selected statement, for the selected companies at
    the wanted time.
3.  **gather\_stock\_time\_series()**: This function takes in a single
    stock ticker symbol and returns historical stock price data from a
    timeframe, returned as a dataframe.
4.  **gather\_stock\_returns()**: This function takes in multiple stock
    ticker symbols, buy-in date, sell-out date and returns a dataframe
    containing the historical prices at buy-in and sell-out date as well
    as the corresponding returns (profit/loss).

### Usage

``` r
library(rintrinio)

# Gather Financial Statement Time Series Function
gather_financial_statement_time_series(api_key = api_key, 
                                       ticker = 'AAPL', 
                                       statement = 'balance_sheet_statement', 
                                       year = c("2018", "2019"),
                                       period = c('Q1'))
#> Warning: Column `type` joining factors with different levels, coercing to
#> character vector
#>                                     type               fin_value
#> 1                                 ticker                    AAPL
#> 2                              statement balance_sheet_statement
#> 3                                   year                    2018
#> 4                                 period                      Q1
#> 5                     cashandequivalents              2.7491e+10
#> 6                   shortterminvestments              4.9662e+10
#> 7                         notereceivable              2.7459e+10
#> 8                     accountsreceivable               2.344e+10
#> 9                           netinventory               4.421e+09
#> 10                    othercurrentassets              1.1337e+10
#> 11                    totalcurrentassets              1.4381e+11
#> 12                                netppe              3.3679e+10
#> 13                   longterminvestments             2.07944e+11
#> 14                              goodwill               5.889e+09
#> 15                      intangibleassets               2.149e+09
#> 16                 othernoncurrentassets              1.3323e+10
#> 17                 totalnoncurrentassets             2.29305e+11
#> 18                           totalassets             4.06794e+11
#> 19                         shorttermdebt             -1.8478e+10
#> 20                       accountspayable             -6.2985e+10
#> 21                       accruedexpenses             -2.6281e+10
#> 22                currentdeferredrevenue              -8.044e+09
#> 23               totalcurrentliabilities            -1.15788e+11
#> 24                          longtermdebt            -1.03922e+11
#> 25             noncurrentdeferredrevenue              -3.131e+09
#> 26            othernoncurrentliabilities             -4.3754e+10
#> 27            totalnoncurrentliabilities            -1.50807e+11
#> 28                      totalliabilities            -2.66595e+11
#> 29           commitmentsandcontingencies                       0
#> 30                          commonequity             -3.6447e+10
#> 31                      retainedearnings            -1.04593e+11
#> 32                                  aoci                8.41e+08
#> 33                     totalcommonequity            -1.40199e+11
#> 34                           totalequity            -1.40199e+11
#> 35 totalequityandnoncontrollinginterests            -1.40199e+11
#> 36             totalliabilitiesandequity            -4.06794e+11
#> 37               othercurrentliabilities                    <NA>
#>                 fin_value.
#> 1                     AAPL
#> 2  balance_sheet_statement
#> 3                     2019
#> 4                       Q1
#> 5               4.4771e+10
#> 6               4.1656e+10
#> 7               1.8904e+10
#> 8               1.8077e+10
#> 9                4.988e+09
#> 10              1.2432e+10
#> 11             1.40828e+11
#> 12              3.9597e+10
#> 13             1.58608e+11
#> 14                    <NA>
#> 15                    <NA>
#> 16              3.4686e+10
#> 17             1.93294e+11
#> 18             3.73719e+11
#> 19             -2.1741e+10
#> 20             -4.4293e+10
#> 21                    <NA>
#> 22              -5.546e+09
#> 23            -1.08283e+11
#> 24             -9.2989e+10
#> 25                    <NA>
#> 26             -5.4555e+10
#> 27            -1.47544e+11
#> 28            -2.55827e+11
#> 29                       0
#> 30              -4.097e+10
#> 31              -8.051e+10
#> 32               3.588e+09
#> 33            -1.17892e+11
#> 34            -1.17892e+11
#> 35            -1.17892e+11
#> 36            -3.73719e+11
#> 37             -3.6703e+10

# Gather Financial Statement Cross-Company Comparison Function
gather_financial_statement_company_compare(api_key = api_key, 
                                           ticker = c("AAPL", "CSCO"), 
                                           statement = "income_statement", 
                                           year = "2018", 
                                           period = "Q1")
#> Warning: Column `name` joining factors with different levels, coercing to
#> character vector
#>                               name          value.x          value.y
#> 1                           ticker             AAPL             CSCO
#> 2                        statement income_statement income_statement
#> 3                             year             2018             2018
#> 4                           period               Q1               Q1
#> 5                 operatingrevenue      -8.8293e+10      -1.2136e+10
#> 6                     totalrevenue      -8.8293e+10      -1.2136e+10
#> 7           operatingcostofrevenue       5.4381e+10        4.709e+09
#> 8               totalcostofrevenue       5.4381e+10        4.709e+09
#> 9                 totalgrossprofit      -3.3912e+10       -7.427e+09
#> 10                      sgaexpense        4.231e+09         5.57e+08
#> 11                       rdexpense        3.407e+09        1.567e+09
#> 12          totaloperatingexpenses        7.638e+09        4.671e+09
#> 13            totaloperatingincome      -2.6274e+10       -2.756e+09
#> 14                     otherincome        -7.56e+08         -6.2e+07
#> 15                totalotherincome        -7.56e+08        -2.06e+08
#> 16               totalpretaxincome       -2.703e+10       -2.962e+09
#> 17                incometaxexpense        6.965e+09         5.68e+08
#> 18             netincomecontinuing      -2.0065e+10       -2.394e+09
#> 19                       netincome      -2.0065e+10       -2.394e+09
#> 20               netincometocommon      -2.0065e+10       -2.394e+09
#> 21        weightedavebasicsharesos      -5112877000       -4.959e+09
#> 22                        basiceps            -3.92            -0.48
#> 23      weightedavedilutedsharesos      -5157787000       -4.994e+09
#> 24                      dilutedeps            -3.89            -0.48
#> 25 weightedavebasicdilutedsharesos      -5118600000      -4987500000
#> 26                 basicdilutedeps            -3.92            -0.48
#> 27           cashdividendspershare            -0.63            -0.29
#> 28                marketingexpense             <NA>        2.334e+09
#> 29             amortizationexpense             <NA>          6.1e+07
#> 30             restructuringcharge             <NA>         1.52e+08
#> 31            totalinterestexpense             <NA>         2.35e+08
#> 32             totalinterestincome             <NA>        -3.79e+08

# Gather Stock Price Time Series Function
gather_stock_time_series(api_key = api_key,
                         ticker = "CSCO",
                         start_date = "2020-02-01",
                         end_date = "2020-02-05")
#>         date intraperiod frequency  open    high   low close   volume adj_open
#> 1 2020-02-05       FALSE     daily 48.33 48.6000 48.15 48.45 17042331    48.33
#> 2 2020-02-04       FALSE     daily 47.22 47.7074 47.11 47.62 13947268    47.22
#> 3 2020-02-03       FALSE     daily 46.40 46.8250 46.21 46.53 15383527    46.40
#>   adj_high adj_low adj_close adj_volume
#> 1  48.6000   48.15     48.45   17042331
#> 2  47.7074   47.11     47.62   13947268
#> 3  46.8250   46.21     46.53   15383527

# Gather Stock Returns Function
gather_stock_returns(api_key = api_key,
                     ticker = c("AAPL", "CSCO"),
                     buy_date = "2019-01-01",
                     sell_date = "2020-01-01")
#>   Stock   Buy.date Buy.price  Sell.date Sell.price Return....
#> 1  AAPL 2019-01-02  155.2140 2019-12-31   292.9547      88.74
#> 2  CSCO 2019-01-02   41.4651 2019-12-31    47.6100      14.82
```

If you are using a Sandbox API key, the following tickers will work in
all of the functions: ‘AAPL’, ‘AXP’, ‘BA’, ‘CAT’, ‘CSCO’, ‘CVX’, ‘DIS’,
‘DWDP’, ‘GE’, ‘GS’, ‘HD’, ‘IBM’, ‘INTC’, ‘JNJ’, ‘JPM’, ‘KO’, ‘MCD’,
‘MMM’, ‘MRK’, ‘MSFT’, ‘NKE’, ‘PFE’, ‘PG’, ‘TRV’, ‘UNH’, ‘UTX’, ‘V’,
‘VZ’, ‘WMT’, ‘XOM’

Available statements include: ‘income\_statement’,
‘balance\_sheet\_statement’, ‘cash\_flow\_statement’

# References

<div id="refs" class="references hanging-indent">

<div id="ref-R">

R Core Team. 2019. *R: A Language and Environment for Statistical
Computing*. Vienna, Austria: R Foundation for Statistical Computing.
<https://www.R-project.org/>.

</div>

<div id="ref-intrinio">

Swagger Codegen community. 2020. *IntrinioSDK: R Package Client for
Intrinio Api*.

</div>

<div id="ref-testthat">

Wickham, Hadley. 2011. “Testthat: Get Started with Testing.” *The R
Journal* 3: 5–10.
<https://journal.r-project.org/archive/2011-1/RJournal_2011-1_Wickham.pdf>.

</div>

<div id="ref-tidyverse">

———. 2017. *Tidyverse: Easily Install and Load the ’Tidyverse’*.
<https://CRAN.R-project.org/package=tidyverse>.

</div>

<div id="ref-knitr">

Xie, Yihui. 2020. *Knitr: A General-Purpose Package for Dynamic Report
Generation in R*. <https://yihui.org/knitr/>.

</div>

</div>
