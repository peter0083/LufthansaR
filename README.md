<div style="max-height:450px; max-width:450px; overflow: hidden">
   <img src="image/hexlogo.png" align="right" alt="hexlogo" height="120" width="120"/>
</div>


[![Build Status](https://travis-ci.org/peter0083/LufthansaR.svg?branch=master)](https://travis-ci.org/peter0083/LufthansaR)

# LufthansaR

an API wrapper package for R


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

To learn how to use `LufthansaR` functions, refer to the [LufthansaR Vignette](vignettes/LufthansaR.md). 

### Software License


The MIT License: see [LICENSE](https://github.com/peter0083/LufthansaR/blob/master/LICENSE)

Getting Help
----------------

You can get help by creating an issue in this repo.

References:
---------------

1. https://icons8.com/icon/set/flight/all

2. [hexSticker library](https://github.com/GuangchuangYu/hexSticker)

3. [ggplot2](https://github.com/tidyverse/ggplot2)
