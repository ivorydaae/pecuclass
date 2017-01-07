rm(list=ls(all.names=TRUE))

#need to modify working directory!!!!
setwd('D:\\大二\\數位應用程式設計\\R_constellation\\plotData')

#read all the file
allFile <- list.files('Daily_horoscope')

zodiac <- c('Aries','Taurus','Gemini','Cancer','Leo','Virgo','Libra','Scorpio','Sagittarius'
            ,'Capricorn','Aquarius','Pisces')
factor <- c('Love','Finance','Career')

creatCom <- ''
for(i in 1:12 ){
  creatCom <- paste0(zodiac[i],'<-','matrix(0,3,',length(allFile),')')
  eval(parse(text=creatCom))
  setRow <- paste0('rownames(',zodiac[i],')<-factor')
  eval(parse(text=setRow))
  
  colname <- c()
  for( j in 1:length(allFile) ){
   colname[j] <- substr( allFile[j],1,10 ) 
  }
  setCol <-  paste0('colnames(',zodiac[i],')<-colname')
  eval(parse(text=setCol))
}

#set all the data
for(i in 1:length(allFile) ){
  filepath <- paste0( 'Daily_horoscope\\',allFile[i] )
  data <- read.csv(filepath)
  for( j in 1:12 ){
    command <- paste0(zodiac[j],'[,i]<-data[,j+1]')
    eval(parse(text=command))
  }
}

draw_plot<- function( plotdata, zodiac ){
  x <- colnames(plotdata)
  #Love
  lY <- plotdata[1,]
  plot(x,lY,type='l',xlim = ,ylim = c(0,5),xlab = zodiac)
  
  #Finance
  lF <- plotdata[2,]
  plot(lF,type='l',ylim = c(0,5),xlab = zodiac)
  
  #Career
  lC <- plotdata[3,]
  plot(lC,type='l',ylim = c(0,5),xlab = zodiac)
  
}

#draw_plot(Aries,zodiac[1])


