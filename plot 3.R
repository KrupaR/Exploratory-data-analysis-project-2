
# Question 3: Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

# Needs plyr libraray
library(plyr)
library(ggplot2)

#read datafiles

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Calculate total PM2.5 emissions by year in Baltimore
Baltimore <- NEI[NEI$fips == "24510", ]
BaltimoreAggregate <- with(Baltimore, aggregate(Emissions, by = list(year), sum))

# set column names for plotting
colnames(BaltimoreAggregate) <- c("year", "Emissions")

#summarize data based on type and year
BaltimoreType <- ddply(Baltimore, .(type, year), summarize, Emissions = sum(Emissions))
BaltimoreType$Pollutant_Type <- Baltimore.Type$type

#ggplot2 qplot 
qplot(year, Emissions, data = BaltimoreType, group = Pollutant_Type, color = Pollutant_Type, 
    geom = c("point", "line"), ylab = "Total Emissions, PM 2.5" , 
    xlab = "Year", main = "Total Emissions in U.S. by Type of Pollutant")


# save graph in a png file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()


