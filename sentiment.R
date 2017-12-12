needs(twitteR)
needs(syuzhet)
needs(lubridate)
needs(scales)
needs(reshape2)
needs(dplyr)
needs(stringr)
needs(jsonlite)
# Declare Twitter API Credentials
api_key <- "8lnpCFsYYf5tg5yjm2ozql0WL" 
api_secret <- "bER9uVmtsBSR7x9DQ1c06DF4riIfiOCgrnomjViTQmWRi5sBzB" 
token <- "1977401202-bwaS9YLmW3guWnfT2lcg4XPKUxciPTrUh3oq4i3"
token_secret <- "2hGZHORNcDA0aWP0fAxMFM1jQN3QzOjpQkVdSfkG23zMs"

setup_twitter_oauth(api_key, api_secret, token, token_secret)

tweets <- searchTwitter(input, n=100)

#print (tweets)

tweetsdf <- twListToDF(tweets)
#write.csv(tweetsdf, file = "MyData.csv")

tweets = sapply(tweets,function(x) x$getText())

Created  <- tweetsdf$created

# CLEANING BEGINS

tweets_cl <- gsub('\\p{So}|\\p{Cn}', '', tweets, perl = TRUE)
tweets_cl = gsub("(RT|via)((?:\\b\\W*@\\w+)+)","",tweets_cl)
tweets_cl = gsub("http[^[:blank:]]+", "", tweets_cl)
tweets_cl = gsub("@\\w+", "", tweets_cl)
tweets_cl = gsub("[ \t]{2,}", "", tweets_cl)
tweets_cl = gsub("^\\s+|\\s+$", "", tweets_cl)
tweets_cl = gsub("[[:punct:]]", " ", tweets_cl)
tweets_cl = gsub("[^[:alnum:]]", " ", tweets_cl)
tweets_cl <- gsub('\\d+', '', tweets_cl)

tweets = tolower(tweets_cl)
print("LOWER DONE")
mySentiment <- get_nrc_sentiment(tweets)
#write.csv(tweets, file = "trumpet3.csv")
tweets <- cbind(tweets, mySentiment)

print("******** PRINTINT t ******")
t<-tweets[c(2:11)]


sentimentTotals <- data.frame(colSums(tweets[c(2:11)]))
print(sentimentTotals)

Created <- with_tz(ymd_hms(Created))

posnegtime <- tweets %>% 
        group_by(timestamp = cut(Created, breaks="2 months")) %>%
        summarise(negative = mean(negative),
                  positive = mean(positive)) %>% melt(id.vars="timestamp")

names(posnegtime) <- c("timestamp", "sentiment", "meanvalue")

posnegtime$sentiment = factor(posnegtime$sentiment,levels(posnegtime$sentiment)[c(1,2)])


posnegtime$sentiment = factor(posnegtime$sentiment,levels(posnegtime$sentiment)[c(2,1)])


tweets$weekday <- wday(Created, label = TRUE)
weeklysentiment <- tweets %>% group_by(weekday) %>% 
        summarise(anger = mean(anger), 
                  anticipation = mean(anticipation), 
                  disgust = mean(disgust), 
                  fear = mean(fear), 
                  joy = mean(joy), 
                  sadness = mean(sadness), 
                  surprise = mean(surprise), 
                  trust = mean(trust)) %>% melt(id.vars="weekday")
names(weeklysentiment) <- c("weekday", "sentiment", "meanvalue")


tweets$month <- month(Created, label = TRUE)
monthlysentiment <- tweets %>% group_by(month) %>% 
        summarise(anger = mean(anger), 
                  anticipation = mean(anticipation), 
                  disgust = mean(disgust), 
                  fear = mean(fear), 
                  joy = mean(joy), 
                  sadness = mean(sadness), 
                  surprise = mean(surprise), 
                  trust = mean(trust)) %>% melt(id.vars="month")
names(monthlysentiment) <- c("month", "sentiment", "meanvalue")

combinedData <-  c(sentimentTotals, posnegtime, weeklysentiment, monthlysentiment)

x <- toJSON(combinedData, pretty=TRUE)
x

