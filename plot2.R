library(plyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")

data_24510 <- NEI[which(NEI$fips == "24510"),]
data <- with(data_24510, aggregate(Emissions, by = list(year), sum))
colnames(data) <- c("year", "Emissions")

png(filename = 'plot2.png', width = 480, height = 480, units = 'px')
plot(data, type = "o", ylab = expression("Total Emissions, PM"[2.5]), xlab = "Year", main = "Total Emissions for Baltimore County", xlim = c(1999, 2008))
dev.off()