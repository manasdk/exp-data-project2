library(lattice)
library(plyr)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

scc_coal <- grep("coal", SCC$Short.Name, ignore.case = TRUE)
scc_coal <- SCC[scc_coal, ]

NEI$SCC <- as.character(NEI$SCC)
nei_coal <- NEI[NEI$SCC %in% as.character(scc_coal$SCC), ]

coal <- with(nei_coal, aggregate(Emissions, by = list(year), sum))

png(filename = 'plot4.png', width = 480, height = 480, units = 'px')
plot(coal, type = "o", ylab = expression("Total Emissions, PM"[2.5]), xlab = "Year", main = "Emissions and Total Coal Combustion for the United States", xlim = c(1999, 2008))
dev.off()