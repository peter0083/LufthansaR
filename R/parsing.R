
# # Example
# airport <- function(){
#

#   # airport_content       #    Uncomment it to see all the received content
#
#   #lat <- airport_content$AirportResource$Airports$Airport$Position$Coordinate$Latitude
#   #lon <- airport_content$AirportResource$Airports$Airport$Position$Coordinate$Longitude
#
#   #df <- data.frame(
#   #  x = lon,
#   #  y = lat)
#   #map <- get_googlemap(center = c(lon = lon, lat = lat), markers = df, scale = 2) %>%
#   #  ggmap(extent = 'device')
#
#   #print(paste0("Here is the map for ", airport, "."))
#   #map
#
# }


# ### create a dataframe from news data
# news_2_df <- function(news){
#   ### go from a news object to a dataframe
#   df <- content(news)$articles%>%
#     map_df(`[`,c("author", "title", "description", "url", "publishedAt"))
#   return(df)
# }
#
#
# ###just get teh headlines
# get_headlines <- function(API_key){
#   ###gives the top 10 headlines as of 15 minutes ago
#   url_link <- glue("https://newsapi.org/v2/top-headlines?sources=cbc-news&apiKey={API_key}")
#   headlines <- GET(url_link)
#   headlines <- content(headlines)$articles
#   my_list <- rep(0,10)
#   for (i in 1:10){
#     my_list[i] <- (headlines[[i]]$title)
#   }
#   return(my_list)
# }
#
# ###just the titles of search
# news_search <- function(keyWord,API_key){
#   ###
#   url_link <- glue("https://newsapi.org/v2/everything?q={keyWord}&sortBy=popularity&sources=cbc-news&apiKey={API_key}")
#
#   news <- GET(url_link)
#   news <- content(news)$articles
#   my_list <- rep(0,length(news))
#   for (i in 1:length(news)){
#     my_list[i] <- (news[[i]]$title)
#   }
#
#   return(my_list)
# }
#
#
# ##### GEtting better data
# get_headline_data <- function(API_key, dataframe= TRUE){
#   url_link <- glue("https://newsapi.org/v2/top-headlines?sources=cbc-news&apiKey={API_key}")
#   headlines <- GET(url_link)
#   ###return a dataframe, or JSON is false
#   if (dataframe==TRUE){
#     headlines <- news_2_df(headlines)
#   }else{
#     headlines <-  content(headlines)$articles
#   }
#   return(headlines)
# }
#
#
# ###A full search
# get_search_data <- function(keyWord,API_key, dataframe= TRUE){
#   url_link <- glue("https://newsapi.org/v2/everything?q={keyWord}&sortBy=popularity&sources=cbc-news&apiKey={API_key}")
#   news <- GET(url_link)
#   if (dataframe==TRUE){
#     news <- news_2_df(news)
#   }else{
#     news <-  content(news)$articles
#   }
#   return(news)
# }
#
#
# #######################
# ### Examples
# ######################
