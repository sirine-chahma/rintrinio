
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rintrinio

<!-- badges: start -->

<!-- badges: end -->

R (R Core Team 2019) package converts Intrinio (Swagger Codegen
community 2020) objects and lists to dataframes.

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

You can install the released version of rintrinio from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("rintrinio")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("Zhang-Haipeng/rintrinio")
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

#### Installing Intrinio R SDK

Please note that the Intrinio R SDK is not available via CRAN. To
install, follow these steps, as outlined in the [Intrinio R
Documentation](https://docs.intrinio.com/documentation/r).

In an R console, install `devtools` if it is not already installed:

``` r
if(!require(devtools)) { install.packages("devtools") }
```

Clone the Intrinio R SDK Github Repository:

``` r
git clone https://github.com/intrinio/r-sdk.git
```

Set your working directory to where you cloned the Intrinio R SDK Github
Repository and install the `IntrinioSDK` package via the R console:

``` r
library(devtools)
install(".")
```

#### Program and Package Dependencies

R version 3.6.1 and R packages:

  - knitr==1.26 (Xie 2020)
  - tidyverse==1.2.1 (Wickham 2017)
  - IntrinioSDK==0.1.0 (Swagger Codegen community 2020)

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

# References

<div id="refs" class="references">

<div id="ref-R">

R Core Team. 2019. *R: A Language and Environment for Statistical
Computing*. Vienna, Austria: R Foundation for Statistical Computing.
<https://www.R-project.org/>.

</div>

<div id="ref-intrinio">

Swagger Codegen community. 2020. *IntrinioSDK: R Package Client for
Intrinio Api*.

</div>

<div id="ref-tidyverse">

Wickham, Hadley. 2017. *Tidyverse: Easily Install and Load the
’Tidyverse’*. <https://CRAN.R-project.org/package=tidyverse>.

</div>

<div id="ref-knitr">

Xie, Yihui. 2020. *Knitr: A General-Purpose Package for Dynamic Report
Generation in R*. <https://yihui.org/knitr/>.

</div>

</div>
