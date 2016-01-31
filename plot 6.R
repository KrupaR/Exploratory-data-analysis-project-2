
# Question 6: Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == 06037). 
# Which city has seen greater changes over time in motor vehicle emissions?


# Needs plyr libraray
library(plyr)
library(ggplot2)

#read datafiles

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset emissions due to motor vehicle sources from 'NEI' for Los Angeles and Baltimore
#Combine it with the data from Baltimore

DescList <- unique(grep("Vehicles", SCC$EI.Sector, ignore.case = TRUE, value = TRUE))
CodesList <- SCC[SCC$EI.Sector %in% DescList, ]["SCC"]
BaltimoreEmission <- NEI[NEI$SCC %in% CodesList$SCC & NEI$fips == "24510", ]
LosAngelesEmission <- NEI[NEI$SCC %in% CodesList$SCC & NEI$fips == "06037", ]
EmissionData <- rbind(BaltimoreEmission, LosAngelesEmission)  

#Calculate the emissions due to motor vehicles in Baltimore and Los Angeles for every year

EmissionsYoYbyCounty <- aggregate(Emissions ~ fips * year, data = EmissionData, FUN = sum)
EmissionsYoYbyCounty$county <- ifelse(EmissionsYoYbyCounty$fips == "06037", "Los Angeles", "Baltimore")


#Plotting Emissions from motor vehicle sources changed from 1999–2008 in Baltimore City
qplot(year, Emissions, data = EmissionsYoYbyCounty , color = county, geom = c("point", "line"), 
      ylab = "Total Emissions, PM 2.5", xlab = "Year", main = "Comparison of Total Emissions by County")


# save graph in a png file
dev.copy(png, file="plot6.png", height=480, width=480)
dev.off()

