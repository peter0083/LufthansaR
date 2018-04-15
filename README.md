
[![Build Status](https://travis-ci.org/peter0083/LufthansaR.svg?branch=master)](https://travis-ci.org/peter0083/LufthansaR)


<h5 align="center">
  <br>
<img src=image/hexlogo.png alt="LufthansaR" width="200"></a>
<br>
</h5>

<h4 align="center">An API wrapper package for R</a>.</h4>

<h5 align="center">
Created by</a></h5>

<h4 align="center">

[Peter Lin](https://github.com/peter0083) &nbsp;&middot;&nbsp;
[Amy Goldlist](https://github.com/amygoldlist) &nbsp;&middot;&nbsp;
[Hatice Cavusoglu](https://github.com/hntek) &nbsp;&middot;&nbsp;
[Joe Sastrillo](https://github.com/joesdesk)
</a></h4>

<br>
<h4 align="center">

[![Travis](https://img.shields.io/travis/UBC-MDS/ptoolkit.svg?style=social)](https://github.com/peter0083/LufthansaR)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
[![GitHub forks](https://img.shields.io/github/forks/peter0083/LufthansaR.svg?style=social)](https://github.com/peter0083/LufthansaR/network)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
[![GitHub issues](https://img.shields.io/github/issues/peter0083/LufthansaR.svg?style=social)](https://github.com/peter0083/LufthansaR/issues)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
[![GitHub stars](https://img.shields.io/github/stars/UBC-MDS/ptoolkit.svg?style=social)](https://github.com/peter0083/LufthansaR/stargazers)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
[![GitHub license](https://img.shields.io/github/license/peter0083/LufthansaR.svg?style=social)](https://github.com/peter0083/LufthansaR/LICENSE)
</a></h4>


# LufthansaR

`LufthansaR` is an API wrapper package for R. It enables programmers to access to [Lufthansa Open API](https://developer.lufthansa.com/docs) from R environment.

This document introduces you to LufthansaR's basic set of tools, and show how to use them. Once you have installed the package, read `vignette("LufthansaR")` to learn more.


## Lufthansa Open API


To have access to Lufthansa Open API, one has to sign in to Mashery, Lufthansa's developer platform, and apply for a key. Please visit [here](https://developer.lufthansa.com/docs/API_basics/). Once you are registered, you will be given:

- a key and
- a secret

These two values can be exchanged for a _short-lived_ access token. A valid access token must be sent with every API request while accessing any Lufthansa's API. In other words, every Lufthansa API requires you to pass Oauth token when getting the data from it.


## How to install LufthansaR

You can install `LufthansaR` development version from GitHub

```{r, eval=FALSE}
devtools::install_github("peter0083/LufthansaR")
```

CRAN version of the package will be scheduled to be added in the next version.

Installation
----------------

You can install `LufthansaR` development version from GitHub

```r
devtools::install_github("peter0083/LufthansaR")
```


Usage (quick start)
-----------------------

You can load `LufthansaR` as follows.

```r
library(LufthansaR)
```

This will load the core `lufthansaR` functions.

Setup your API key and secret in the environment.

Use the `get_token()` function to create an access token.

```r
LufthansaR::get_token()
```

## How to deal with Lufthansa Open API credentials

You can store your client ID and secret in a `~/.Renviron` file. R loads this file as
a system variable in each new session. The package uses these variables to request
new keys if needed. The `.Renviron` file should contain the lines

```
LUFTHANSA_API_CLIENT_ID = 'xxxxxxxxxxxxxxxxxxxxxxxx'
LUFTHANSA_API_CLIENT_SECRET = 'xxxxxxxxxx'
```

which specify the key and secret pair. This package does not remember the id or the
secret.


**NOTE: The name of the variables should be EXACTLY:**

- `LUFTHANSA_API_CLIENT_ID`
- `LUFTHANSA_API_CLIENT_SECRET`


Because tokens last for 1.5 days and to prevent the abuse of continuously requesting
new tokens, the package by default stores the token and its expiry in a file in the
working directory called `.lufthansa-token`. Caching the token provides a way of
using it across R sessions until it expires. Functions in the package use the `get_token()`
command to access the API. For more information about the function, see `help(get_token)`.

Caching the token can be turned off by setting the following R option through
```
options(lufthansar_token_cache = FALSE)
```

Alternately, one can choose where to cache the token by using a filename instead
```
options(lufthansar_token_cache = 'path/to/.token-cache')
```

Users can see the token being used and its expiry by calling
```
LufthansaR::get_creds_from_env()
```

## Functions

`LufthansaR` has four core functions:
 * `get_flight_status()` provides on the status of a given flight and day

 * `get_flight_status_arrival()` provides information about all flights arriving at a given airport on a given day

  * `get_flight_status_departure()` provides information about all flights departing from a given airport on a given day

  * `airport()` provides general information about a given airport

To learn how to use these `LufthansaR` functions, refer to the [LufthansaR Vignette](vignettes/LufthansaR.md).


## Uninstalling

To uninstall `LufthansaR`, simply run:

```
remove.packages('LufthansaR')
```


## Software License

The MIT License: see [LICENSE](https://github.com/peter0083/LufthansaR/blob/master/LICENSE)


## Contributing

If you have trouble with this package, you can get help us improve by creating an issue in this repo.   Please use the [template](ISSUE_TEMPLATE.md) provided to ensure we have all the information needed to help solve the issue

If you are interested in being a contributor to `LufthansaR`, consult our [contributing policies](CONTRIBUTING), and send us a pull request!


References:
---------------

1. https://icons8.com/icon/set/flight/all

2. [hexSticker library](https://github.com/GuangchuangYu/hexSticker)

3. [ggplot2](https://github.com/tidyverse/ggplot2)
