library(XML)
library(dplyr)
prices <- data.frame(readHTMLTable("http://www.joburgmarket.co.za/dailyprices.php?commodity=64&containerall=2"))
prices <- mutate(prices,Sys.Date())
colnames(prices) <- c("Container", "UnitMass", "ProductName", "TotalValueSold", "TotalQuantitySold", "TotalKgSold", "AveragePrice", "HighestPrice", "AveragePriceperKg", "HighestPriceperKg", "Date")
prices[,4] <- gsub(",", "", prices[,4])
prices[,c(2,4,7:10)] <- as.numeric(gsub("R", "", as.matrix(prices[,c(2,4,7:10)])))
prices <- prices %>% filter(TotalValueSold>0) %>% arrange(AveragePriceperKg)
write.table(prices, file="JoburgOranges.csv", sep=",", col.names=F, row.names=F, append=TRUE)

