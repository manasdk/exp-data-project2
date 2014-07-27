library(ggplot2)
library(plyr)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

scc_motor <- grep("motor", SCC$Short.Name, ignore.case = TRUE)
scc_motor <- SCC[scc_motor,]

NEI$SCC <- as.character(NEI$SCC)
nei_motor <- NEI[NEI$SCC %in% as.character(scc_motor$SCC),]

nei_motor_24510 <- nei_motor[which(nei_motor$fips == "24510"),]
data <- with(nei_motor_24510, aggregate(Emissions, by = list(year), sum))

png(filename = 'plot5.png', width = 480, height = 480, units = 'px')
plot(data, type = "o", ylab = expression("Total Emissions, PM"[2.5]), xlab = "Year", main = "Total Emissions from Motor Vehicle Sources")
dev.off()