################## SUMMARIZE MAPS FROM LANDIS-II RUNS #####################
########################## Summarizes across multiple LANDIS-II scenarios  ################################
#################################Created by M. Lucash, adapted from M. Creutzburg's file


 library(ggplot2)
# library(gridExtra)
# library(gridGraphics)
 library(png)
# library(plyr)


# Set working directory
dir <- "I:/Research/Shares/lucash_lab/Lucash/DoD_Model_Comparison/Output/PnET_BiomassMaps/"
setwd(dir)

#Set output directory
output_dir<-("I:/Research/Shares/lucash_lab/Lucash/DoD_Model_Comparison/Output/PnET_BiomassMaps/Outputs/")

# Useful if you have multiple replicates
no_reps <- 1  # input nummber of replicates here

# Load two lookup tables for joining to data to make the graphs look nicer.

Scenario_LUT <- read.csv ("Scenarios_071919.csv")

Year_LUT <- read.csv (paste(dir, "LUT_Year_1y.csv", sep=""))
Year_LUT_50y <- Year_LUT[1:51,]

#Read in the data.  This comes from the output file in MultipleScenarios_SppMaps.R
original_data <- read.csv(paste(output_dir, "SppBiomass-Summary.csv", sep=""))
head(original_data)

#Merging with tables to make the graphs look nicer.

original_data_scenario <- merge(original_data, Scenario_LUT, by.x="ScenarioName", by.y="Folder")
head(original_data_scenario)

original_data_scenario_Time <- merge(original_data_scenario, Year_LUT_50y, by.x="Time", by.y="Time", all=TRUE)
graphing_Totalbiomass<-subset (original_data_scenario_Time, original_data_scenario_Time$Species %in% "TotalBiomass")

head(graphing_Totalbiomass)

#Number of colors corresponds to scenarios
# plt.cols.short <- c("#000000", "#E69F00", "#D55E00") 
plt.cols.short <- c("#E69F00", "#009E73", "#F0E442", "#56B4E9", "#D55E00","#0072B2", "#E69F00", "#009E73", "#F0E442", "#56B4E9", "#D55E00","#0072B2")


#Graph for total biomass of all scenarios together on one graph
# dev.off()
  png_name<-paste(output_dir, "Biomass_vs_Time_071619.png", sep="")
  
  output.plot.v1<-ggplot(graphing_Totalbiomass, aes(x=Year, y= Avg_Biomass_gm2, group = as.factor(Scenarios)))+ theme_classic()+ geom_line(aes(linetype = Scenarios, color = Scenarios), size=1.3) + scale_linetype_manual(values=c("solid", "solid", "solid", "solid", "solid", "solid", "dashed", "dashed", "dashed", "dashed", "dashed", "dashed"))+scale_color_manual(values=plt.cols.short) +scale_y_continuous(limits=c(0,30000))+scale_x_continuous(limits=c(2010,2060))+
  ggtitle("Overall Trends in Biomass") +theme(plot.title = element_text(size=30, margin = margin(t = 10, b = -20), hjust=0.1)) +xlab("Time")+ylab("Aboveground biomass (g/m2)") + theme(legend.key.width=unit(1.5,"cm"))


  ggsave(output.plot.v1, filename = png_name, width=11, height=8.5, units="in")
  # dev.off()
  
  ######################################################
  
  #Graph of ANPP. This is not working right now.

final_data<- subset(all_data2, all_data2$Time >0)

png_name<-paste(output_dir, "ANPP_vs_Time_071619.png", sep="")

output.plot.v2<-ggplot(final_data, aes(x=Year, y= AG_NPPC, group = as.factor(Scenarios)))+ theme_classic()+ geom_line(aes(linetype = Scenarios, color = Scenarios), size=1.3) + scale_linetype_manual(values=c("solid", "solid", "solid", "solid", "solid", "solid", "dashed", "dashed", "dashed", "dashed", "dashed", "dashed"))+scale_color_manual(values=plt.cols.short) +scale_y_continuous(limits=c(200,1200))+scale_x_continuous(limits=c(2010,2060))+
  ggtitle("Overall Trends in ANPP") +theme(plot.title = element_text(size=30, margin = margin(t = 10, b = -20), hjust=0.1)) +xlab("Time")+ylab("Aboveground biomass (g/m2)") + theme(legend.key.width=unit(1.5,"cm"))
ggsave(output.plot.v2, filename = png_name, width=11, height=8.5, units="in")
# dev.off()



  list.files(output_dir)
  
  