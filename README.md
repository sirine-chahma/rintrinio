
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rintrinio

<!-- badges: start -->

<!-- badges: end -->

R package converts Intrinio objects and lists to dataframes.

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
transform Intrinio objects into either R dataframes. This will enable
users of the data to make the most of Intrinio’s reliable and
easy-to-use API platform, as well as the analysis capabilities that are
available in R’s environment.

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

Before using any functions included in this package, you must sign up
for an appropriate [Intrinio account](https://intrinio.com/). Once you
have signed up for the appropriate account, you can find your API key
(which is a required argument in all functions) by doing the following:

1.  In the top right corner, select `My Account`
2.  In the left hand menu, select `API KEYS`
3.  Copy your relevant API Key. Note that this is unique to you and
    should not be shared.

<!-- end list -->

  - TODO

## Functions

1.  **gather\_financial\_statement\_time\_series()**:
2.  **gather\_financial\_statement\_company\_compare()**:
3.  **gather\_stock\_time\_series()**: This function takes in a single
    stock ticker symbol and returns historical stock price data from a
    timeframe, returned as a dataframe.
4.  **gather\_stock\_returns()**: This function takes in multiple stock
    ticker symbols, buy-in date, sell-out date and returns a dataframe
    containing the historical prices at buy-in and sell-out date as well
    as the corresponding returns (profit/loss).

## Example

This is a basic example which shows you how to solve a common problem:

``` r
#library(rintrinio)
## basic example code
```

What is special about using `README.Rmd` instead of just `README.md`?
You can include R chunks like so:

``` r
#summary(cars)
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date.

You can also embed plots, for example:

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub\!
