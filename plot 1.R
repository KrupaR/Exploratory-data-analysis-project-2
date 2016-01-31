# Question 1 : Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

# Needs plyr libraray
library(plyr)

#read datafiles

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Calculate total PM2.5 emissions by year
TotalPM25ByYear <- tapply(NEI$Emissions, NEI$year, sum)

## Create line graph 

plot(TotalPM25ByYear, x = rownames(TotalPM25ByYear), type = "n", axes = FALSE, 
    ylab = expression("Total PM"[2.5] * " Emission (in tons)"), 
    xlab = "Year", 
    main = expression("Total PM"[2.5] * " Emission (1999 - 2008)"))

points(TotalPM25ByYear, x = rownames(TotalPM25ByYear), pch = 16, col = "black")
lines(TotalPM25ByYear, x = rownames(TotalPM25ByYear), col = "blue")
axis(2)
axis(side = 1, at = seq(1999, 2008, by = 3))
box()

# save graph in a png file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()

