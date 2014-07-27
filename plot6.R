library(plyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


scc_motor <- grep("motor", SCC$Short.Name, ignore.case = TRUE)
scc_motor <- SCC[scc_motor, ]
NEI$SCC <- as.character(NEI$SCC)
nei_motor <- NEI[NEI$SCC %in% as.character(scc_motor$SCC), ]

nei_motor_24510 <- nei_motor[which(nei_motor$fips == "24510"),]
nei_motor_06037 <- nei_motor[which(nei_motor$fips == "06037"),]

data_24510 <- with(nei_motor_24510, aggregate(Emissions, by = list(year), sum))
data_24510$group <- rep("Baltimore County", length(data_24510[,1]))

data_06037 <- with(nei_motor_06037, aggregate(Emissions, by = list(year), sum))
data_06037$group <- rep("Los Angeles County", length(data_06037[,1]))

data_combined <- rbind(data_24510, data_06037)
data_combined$group <- as.factor(data_combined$group)

colnames(data_combined) <- c("Year", "Emissions", "Group")

png(filename = 'plot6.png', width = 480, height = 480, units = 'px')
print(qplot(Year, Emissions, data = data_combined, group = Group, color = Group, 
      geom = c("point", "line"), ylab = expression("Total Emissions, PM"[2.5]), 
      xlab = "Year", main = "Comparison of Total Emissions by County"))
dev.off()