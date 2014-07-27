library(plyr)
library(ggplot2)

NEI <- readRDS('summarySCC_PM25.rds')

data <- with(NEI, aggregate(Emissions, by = list(year), sum))

png(filename = 'plot1.png', width = 480, height = 480, units = 'px')
plot(data, type = "o", ylab = expression("Total Emissions, PM"[2.5]), 
     xlab = "Year", main = "Total Emissions in the United States")
dev.off()
