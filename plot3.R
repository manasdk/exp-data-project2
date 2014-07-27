library(plyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")

data_24510 <- NEI[which(NEI$fips == "24510"),]
data <- with(data_24510, aggregate(Emissions, by = list(year), sum))
colnames(data) <- c("year", "Emissions")

types <- ddply(data_24510, .(type, year), summarize, Emissions = sum(Emissions))
types$Pollutant_Type <- types$type

png(filename = 'plot3.png', width = 480, height = 480, units = 'px')
print(qplot(year, Emissions, data = types, group = Pollutant_Type, color = Pollutant_Type, geom = c("point", "line"), ylab = expression("Total Emissions, PM"[2.5]), xlab = "Year", main = "Total Emissions in U.S. by Type of Pollutant"))
dev.off()
