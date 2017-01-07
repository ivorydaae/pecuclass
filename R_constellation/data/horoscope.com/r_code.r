library(XML)
library(RCurl)
library(httr)

rm(list=ls(all.names=TRUE))


#modify the working directory!!!!!!!
setwd('D:\\大二\\數位應用程式設計\\R_constellation\\data\\horoscope.com')

indexUrl <- "http://www.horoscope.com/us/horoscopes/general/horoscope-general-daily-today.aspx?sign="

zodiac <- c('Aries','Taurus','Gemini','Cancer','Leo','Virgo','Libra','Scorpio','Sagittarius'
            ,'Capricorn','Aquarius','Pisces')

#get url
url <- c()

for( i in 1:12){
  a <- paste0(indexUrl,i)
  url <- c(url,a)
}

factor <- c('Love','Finance','Career')
factorXpath <- '//div[@class="block-daily-facts-rat-div"]/noscript/img/@src'

data <- matrix(0,3,12)

rownames(data) <- factor
colnames(data) <- zodiac

for( i in 1:12 ){
  tmp <- getURL(url[i])
  xmldoc <- htmlParse(tmp)
  rawdata <- xpathSApply(xmldoc,factorXpath)
  
  score <- c(as.numeric( substr(rawdata[1],23,23) ),as.numeric( substr(rawdata[2],23,23))
             ,as.numeric( substr(rawdata[4],23,23) ))
  data[,i] <- score
}

date <- Sys.Date()

filename <- paste0('horoscope.com',date,'.csv')

write.csv(data,filename)
