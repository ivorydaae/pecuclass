library(XML)
library(RCurl)
library(httr)

rm(list=ls(all.names=TRUE))


#need to modify the working directory!!!!!!!
setwd('D:\\大二\\數位應用程式設計\\R_constellation\\data\\httpm.click108.com')

fpUrl <- 'http://m.click108.com.tw/astro/index.php?astroNum='

zodiac <- c('Aries','Taurus','Gemini','Cancer','Leo','Virgo','Libra','Scorpio','Sagittarius'
            ,'Capricorn','Aquarius','Pisces')
factor <- c('Love','Finance','Career')

data <- matrix(0,3,12)
rownames(data) <- factor
colnames(data) <- zodiac


xmlPathLove <- '//div[@id="astroDailyScore_love"]/@style'
xmlPathCareer <- '//div[@id="astroDailyScore_career"]/@style'
xmlPathMoney <- '//div[@id="astroDailyScore_money"]/@style'


for( i in 1:12){
  url <- paste0(fpUrl,i)
  
  tmp <- getURL(url,encoding='big5')
  
  xmldoc <- htmlParse(tmp)
  
  love <- xpathSApply(xmldoc,xmlPathLove)
  money <- xpathSApply(xmldoc,xmlPathMoney)
  career <-xpathSApply(xmldoc,xmlPathCareer)
  
  score <- c( as.numeric(substr(love,84,84)),
              as.numeric(substr(money,85,85)),
              as.numeric(substr(career,84,84))
              )
  data[,i] <- score
}

date <- Sys.Date()

filename <- paste0('httpm.click108.com',date,'.csv')

write.csv(data,filename)
