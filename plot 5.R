
# Question 5: How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

# Needs plyr libraray
library(plyr)
library(ggplot2)

#read datafiles

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Identify motor vehicle sources from SCC
DescList <- unique(grep("Vehicles", SCC$EI.Sector, ignore.case = TRUE,value = TRUE))
CodesList <- SCC[SCC$EI.Sector %in% DescList, ]["SCC"]

## Subset data for emissions due to motor vehicle sources in from NEI for Baltimore (24510)
BaltimoreEmission <- NEI[NEI$SCC %in% CodesList$SCC & NEI$fips == "24510", ]

## Calculate the emissions due to motor vehicles in Baltimore for every year
EmissionsByYear <- tapply(BaltimoreEmission$Emissions,BaltimoreEmission$year, sum)


#Plotting Emissions from motor vehicle sources changed from 1999–2008 in Baltimore City

plot(EmissionsByYear, x = rownames(EmissionsByYear),type = "n", axes = FALSE, 
       ylab = "Motor Vehicle Related PM 2.5 Emission (in tons)", 
       xlab = "Year", 
       main = "Motor Vehicle Related PM 2.5 Emission in Baltimore (1999 - 2008)" )


# Enhance Graph by adding line, points and box 
points(EmissionsByYear, x = rownames(EmissionsByYear), pch = 23, col = "black")

lines(EmissionsByYear, x = rownames(EmissionsByYear),col = "blue")

axis(2)
axis(side = 1, at = seq(1999, 2008, by = 3))
box()


# save graph in a png file
dev.copy(png, file="plot5.png", height=480, width=480)
dev.off()


