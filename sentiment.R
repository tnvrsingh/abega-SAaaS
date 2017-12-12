needs(twitteR)
needs(syuzhet)
needs(lubridate)
#needs(ggplot2)
needs(scales)
needs(reshape2)
needs(dplyr)
needs(stringr)
needs(wordcloud)
needs(tm)

# Declare Twitter API Credentials
api_key <- "nOMPqC5PNtElymf02yilCTbLH" # From dev.twitter.com
api_secret <- "QlVUeKwt4vB1Qkw0LS4OaXrMAU000nPUFO7EXbu1wWADv8yNHX" # From dev.twitter.com
token <- "1977401202-j67KajnfdJjVnvewXvakyWDJVD6GulJm1u81Reh" # From dev.twitter.com
token_secret <- "vOARZdGRQFVw0pwDakwnzaQup9ysSkd1PqzAVLR82VOL5" # From dev.twitter.com

setup_twitter_oauth(api_key, api_secret, token, token_secret)

tweets <- searchTwitter(input, n=200)

#print (tweets)

tweets.df <- twListToDF(tweets)
tweets = sapply(tweets,function(x) x$getText())

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

tweetsb = tweets

mySentiment <- get_nrc_sentiment(tweets)
print ("sentiment analysis done!")

write.csv(tweets, file = "trumpet3.csv")
print("written to file")

print("***** PRINTING SENTIMENT *****")
#print(mySentiment)

tweets <- cbind(tweets, mySentiment)
print ("Sentiment binding done")

#tweets

print("******** PRINTINT t ******")
t<-tweets[c(2:11)]
#print(t)

print("**** SENTIMENT TOTALS")

sentimentTotals <- data.frame(colSums(tweets[c(2:11)]))
print(sentimentTotals)
# names(sentimentTotals) <- "count"
# sentimentTotals <- cbind("sentiment" = rownames(sentimentTotals), sentimentTotals)
# rownames(sentimentTotals) <- NULL
# ggplot(data = sentimentTotals, aes(x = sentiment, y = count)) +
#         geom_bar(aes(fill = sentiment), stat = "identity") +
#         theme(legend.position = "none") +
#         xlab("Sentiment") + ylab("Total Count") + ggtitle("Total Sentiment Score for All Tweets")

# wordCorpus <- Corpus(VectorSource(tweetsb))
# wordCorpus <- tm_map(wordCorpus, stemDocument)
# wordcloud(words = wordCorpus , scale=c(5,0.1), max.words=100, random.order=FALSE, 
#           rot.per=0.35, use.r.layout=FALSE)

