<div style="max-height:450px; max-width:450px; overflow: hidden">
   <img src="image/hexlogo.png" align="right" alt="hexlogo" height="120" width="120"/>
</div>


[![Build Status](https://travis-ci.org/peter0083/LufthansaR.svg?branch=master)](https://travis-ci.org/peter0083/LufthansaR)

# LufthansaR

an API wrapper package for R

`LufthansaR` is an API wrapper package for R. It enables developers to access to [Lufthansa Open API](https://developer.lufthansa.com/docs) from a R environment. 

This document will walk you through the basic functions of LufthansaR package. Once you have installed the package, read [`vignette("LufthansaR")`](https://lufthansarpackage.wordpress.com/2018/04/15/lufthansar-package-first-release/) to learn more.


Lufthanse Open API
----------------------

Lufthansa provides a set of great APIs. I have explored a few of them here. 

To be able to have access to [Lufthansa Open API](https://developer.lufthansa.com/docs), one has to sign in to Mashery (Lufthansa's developer platform). To use their API one must first register an application and apply for a key. Once you registered, you will be given two values will be given: 

- a key and 
- a secret. 

These two values can be exchanged for a short-lived access token. A valid access token must be sent with every request while accessing any Lufthansa's API. In other words, every Lufthansa API requires you to pass Oauth token when getting the data from it.


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

Get the flight status.

```r
f_status <- LufthansaR::get_flight_status("LH493")

# Departure Status
f_status$Departure$TimeStatus$Definition
```

The default is the flight status for today. However, you can call 5 days into the future by passing `dep_date="2018-04-15"` argument. The departure date (YYYY-MM-DD) in the local time of the departure airport.


Learning LufthansaR
-----------------------

If you are new to API, you should start by reading [the vignette on lufthansar.github.io](https://lufthansarpackage.wordpress.com/2018/04/15/lufthansar-package-first-release/).


Software License
--------------------

The MIT License: see [LICENSE](https://github.com/peter0083/LufthansaR/blob/master/LICENSE)

Getting Help
----------------

You can get help by creating an issue in this repo.

References:
---------------

1. https://icons8.com/icon/set/flight/all

2. [hexSticker library](https://github.com/GuangchuangYu/hexSticker)

3. [ggplot2](https://github.com/tidyverse/ggplot2)
