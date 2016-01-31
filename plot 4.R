
# Question 4: Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

# Needs plyr libraray
library(plyr)
library(ggplot2)

#read datafiles

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


#Find all the coal combustion related sources from SCC
CoalCombustion <- SCC[SCC$EI.Sector == "Fuel Comb - Comm/Institutional - Coal",]["SCC"]

## Subset emissions due to coal combustion sources from 'NEI'
Emission <- NEI[NEI$SCC %in% CoalCombustion$SCC, ]

## Calculate the emissions due to coal each year across United States
TotalEmissionsByYear <- tapply(Emission$Emissions, Emission$year,sum)

#Plotting emissions of PM2.5 from coal combustion related sources in United States between 1999 - 2008
plot(TotalEmissionsByYear, x = rownames(TotalEmissionsByYear), type = "n", 
    axes = FALSE, ylab = "Coal Related PM 2.5 Emission (in tons)", 
    xlab = "Year", main = "Coal Related PM 2.5 Emission across United States (1999 - 2008)" )

# Enhance Graph by adding line, points and box 
points(TotalEmissionsByYear, x = rownames(TotalEmissionsByYear), pch = 23, col = "black")
lines(TotalEmissionsByYear, x = rownames(TotalEmissionsByYear), col = "blue")
axis(2)
axis(side = 1, at = seq(1999, 2008, by = 3))
box()


# save graph in a png file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()



