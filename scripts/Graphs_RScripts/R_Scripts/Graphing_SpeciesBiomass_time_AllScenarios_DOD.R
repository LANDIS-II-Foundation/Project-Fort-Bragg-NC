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
FortBragg_data<-(original_data_scenario_Time[!(original_data_scenario_Time$Species=="TotalBiomass"),])

head(FortBragg_data)

#plt.cols.short <- c("blue", "orange", "black","gray","darkslateblue","orangered")
plt.cols.short <- c("#E69F00", "#009E73", "#F0E442", "#56B4E9", "#D55E00","#0072B2", "#E69F00", "#009E73", "#F0E442", "#56B4E9", "#D55E00","#0072B2")


#Graph for all scenarios for Loblolly
  png_name<-paste(output_dir, "LoblollyBiomass_vs_Time_071919.png", sep="")
  Loblolly_data<-(FortBragg_data[(FortBragg_data$Species=="LobPine"),])
  output.plot.Lob<-ggplot(Loblolly_data, aes(x=Year, y= Avg_Biomass_gm2, group = as.factor(Scenarios)))+ theme_classic()+ geom_line(aes(linetype = Scenarios, color = Scenarios), size=1.3) + scale_linetype_manual(values=c("solid", "solid", "solid", "solid", "solid", "solid", "dashed", "dashed", "dashed", "dashed", "dashed", "dashed"))+scale_color_manual(values=plt.cols.short) +scale_y_continuous(limits=c(0,10000))+scale_x_continuous(limits=c(2010,2060))+
  ggtitle("Loblolly Biomass") +theme(plot.title = element_text(size=30, margin = margin(t = 10, b = -20), hjust=0.1)) +xlab("Time")+ylab("Aboveground biomass (g/m2)") + theme(legend.key.width=unit(1.5,"cm"))
  ggsave(output.plot.Lob, filename = png_name, width=11, height=8.5, units="in")
  # dev.off()
  
  #Graph for all scenarios for Longleaf
  png_name<-paste(output_dir, "LongleafBiomass_vs_Time_071919.png", sep="")
  Longleaf_data<-(FortBragg_data[(FortBragg_data$Species=="LongleafPine"),])
  output.plot.Long<-ggplot(Longleaf_data, aes(x=Year, y= Avg_Biomass_gm2, group = as.factor(Scenarios)))+ theme_classic()+ geom_line(aes(linetype = Scenarios, color = Scenarios), size=1.3) + scale_linetype_manual(values=c("solid", "solid", "solid", "solid", "solid", "solid", "dashed", "dashed", "dashed", "dashed", "dashed", "dashed"))+scale_color_manual(values=plt.cols.short) +scale_y_continuous(limits=c(0,15000))+scale_x_continuous(limits=c(2010,2060))+
  ggtitle("Longleaf Biomass") +theme(plot.title = element_text(size=30, margin = margin(t = 10, b = -20), hjust=0.1)) +xlab("Time")+ylab("Aboveground biomass (g/m2)") + theme(legend.key.width=unit(1.5,"cm"))
  ggsave(output.plot.Long, filename = png_name, width=11, height=8.5, units="in")
  # dev.off()

  #Graph for all scenarios for SweetGum
  png_name<-paste(output_dir, "SweetGumBiomass_vs_Time_071919.png", sep="")
  SweetGum_data<-(FortBragg_data[(FortBragg_data$Species=="SweetGum"),])
  output.plot.Sweet<-ggplot(SweetGum_data, aes(x=Year, y= Avg_Biomass_gm2, group = as.factor(Scenarios)))+ theme_classic()+ geom_line(aes(linetype = Scenarios, color = Scenarios), size=1.3) + scale_linetype_manual(values=c("solid", "solid", "solid", "solid", "solid", "solid", "dashed", "dashed", "dashed", "dashed", "dashed", "dashed"))+scale_color_manual(values=plt.cols.short) +scale_y_continuous(limits=c(0,500))+scale_x_continuous(limits=c(2010,2060))+
  ggtitle("Sweetgum Biomass") +theme(plot.title = element_text(size=30, margin = margin(t = 10, b = -20), hjust=0.1)) +xlab("Time")+ylab("Aboveground biomass (g/m2)") + theme(legend.key.width=unit(1.5,"cm"))
  ggsave(output.plot.Sweet, filename = png_name, width=11, height=8.5, units="in")
  # dev.off()  

#Graph for all scenarios for Shortpine
png_name<-paste(output_dir, "ShortPineBiomass_vs_Time_071919.png", sep="")
ShortPine_data<-(FortBragg_data[(FortBragg_data$Species=="ShortPine"),])
output.plot.Short<-ggplot(ShortPine_data, aes(x=Year, y= Avg_Biomass_gm2, group = as.factor(Scenarios)))+ theme_classic()+ geom_line(aes(linetype = Scenarios, color = Scenarios), size=1.3) + scale_linetype_manual(values=c("solid", "solid", "solid", "solid", "solid", "solid", "dashed", "dashed", "dashed", "dashed", "dashed", "dashed"))+scale_color_manual(values=plt.cols.short) +scale_y_continuous(limits=c(0,200))+scale_x_continuous(limits=c(2010,2060))+
  ggtitle("Short Pine Biomass") +theme(plot.title = element_text(size=30, margin = margin(t = 10, b = -20), hjust=0.1)) +xlab("Time")+ylab("Aboveground biomass (g/m2)") + theme(legend.key.width=unit(1.5,"cm"))
ggsave(output.plot.Short, filename = png_name, width=11, height=8.5, units="in")
# dev.off()  

#Graph for all scenarios for Slash
png_name<-paste(output_dir, "SlashBiomass_vs_Time_071919.png", sep="")
Slash_data<-(FortBragg_data[(FortBragg_data$Species=="SlashPine"),])
output.plot.Slash<-ggplot(Slash_data, aes(x=Year, y= Avg_Biomass_gm2, group = as.factor(Scenarios)))+ theme_classic()+ geom_line(aes(linetype = Scenarios, color = Scenarios), size=1.3) + scale_linetype_manual(values=c("solid", "solid", "solid", "solid", "solid", "solid", "dashed", "dashed", "dashed", "dashed", "dashed", "dashed"))+scale_color_manual(values=plt.cols.short) +scale_y_continuous(limits=c(0,500))+scale_x_continuous(limits=c(2010,2060))+
  ggtitle("Slash Pine Biomass") +theme(plot.title = element_text(size=30, margin = margin(t = 10, b = -20), hjust=0.1)) +xlab("Time")+ylab("Aboveground biomass (g/m2)") + theme(legend.key.width=unit(1.5,"cm"))
ggsave(output.plot.Slash, filename = png_name, width=11, height=8.5, units="in")
# dev.off()  

#Graph for all scenarios for WhiteOak
png_name<-paste(output_dir, "WhiteOakBiomass_vs_Time_071919.png", sep="")
WhiteOak_data<-(FortBragg_data[(FortBragg_data$Species=="WhiteOak"),])
output.plot.WhiteOak<-ggplot(WhiteOak_data, aes(x=Year, y= Avg_Biomass_gm2, group = as.factor(Scenarios)))+ theme_classic()+ geom_line(aes(linetype = Scenarios, color = Scenarios), size=1.3) + scale_linetype_manual(values=c("solid", "solid", "solid", "solid", "solid", "solid", "dashed", "dashed", "dashed", "dashed", "dashed", "dashed"))+scale_color_manual(values=plt.cols.short) +scale_y_continuous(limits=c(0,300))+scale_x_continuous(limits=c(2010,2060))+
  ggtitle("White Oak Biomass") +theme(plot.title = element_text(size=30, margin = margin(t = 10, b = -20), hjust=0.1)) +xlab("Time")+ylab("Aboveground biomass (g/m2)") + theme(legend.key.width=unit(1.5,"cm"))
ggsave(output.plot.WhiteOak, filename = png_name, width=11, height=8.5, units="in")
# dev.off()  

#Graph for all scenarios for Turkey Oak
png_name<-paste(output_dir, "TurkeyOakBiomass_vs_Time_071919.png", sep="")
TurkeyOak_data<-(FortBragg_data[(FortBragg_data$Species=="TurkeyOak"),])
output.plot.TurkeyOak<-ggplot(TurkeyOak_data, aes(x=Year, y= Avg_Biomass_gm2, group = as.factor(Scenarios)))+ theme_classic()+ geom_line(aes(linetype = Scenarios, color = Scenarios), size=1.3) + scale_linetype_manual(values=c("solid", "solid", "solid", "solid", "solid", "solid", "dashed", "dashed", "dashed", "dashed", "dashed", "dashed"))+scale_color_manual(values=plt.cols.short) +scale_y_continuous(limits=c(0,300))+scale_x_continuous(limits=c(2010,2060))+
  ggtitle("Turkey Oak Biomass") +theme(plot.title = element_text(size=30, margin = margin(t = 10, b = -20), hjust=0.1)) +xlab("Time")+ylab("Aboveground biomass (g/m2)") + theme(legend.key.width=unit(1.5,"cm"))
ggsave(output.plot.TurkeyOak, filename = png_name, width=11, height=8.5, units="in")
# dev.off()  

#Graph for all scenarios for Red Maple
png_name<-paste(output_dir, "RedMapleBiomass_vs_Time_071919.png", sep="")
RedMaple_data<-(FortBragg_data[(FortBragg_data$Species=="RedMaple"),])
output.plot.RedMaple<-ggplot(RedMaple_data, aes(x=Year, y= Avg_Biomass_gm2, group = as.factor(Scenarios)))+ theme_classic()+ geom_line(aes(linetype = Scenarios, color = Scenarios), size=1.3) + scale_linetype_manual(values=c("solid", "solid", "solid", "solid", "solid", "solid", "dashed", "dashed", "dashed", "dashed", "dashed", "dashed"))+scale_color_manual(values=plt.cols.short) +scale_y_continuous(limits=c(0,1000))+scale_x_continuous(limits=c(2010,2060))+
  ggtitle("Red Maple Biomass") +theme(plot.title = element_text(size=30, margin = margin(t = 10, b = -20), hjust=0.1)) +xlab("Time")+ylab("Aboveground biomass (g/m2)") + theme(legend.key.width=unit(1.5,"cm"))
ggsave(output.plot.RedMaple, filename = png_name, width=11, height=8.5, units="in")
# dev.off()  

#Graph for all scenarios for Tulip Tree
png_name<-paste(output_dir, "TulipTreeBiomass_vs_Time_071919.png", sep="")
TulipTree_data<-(FortBragg_data[(FortBragg_data$Species=="TulipTree"),])
output.plot.Tulip<-ggplot(TulipTree_data, aes(x=Year, y= Avg_Biomass_gm2, group = as.factor(Scenarios)))+ theme_classic()+ geom_line(aes(linetype = Scenarios, color = Scenarios), size=1.3) + scale_linetype_manual(values=c("solid", "solid", "solid", "solid", "solid", "solid", "dashed", "dashed", "dashed", "dashed", "dashed", "dashed"))+scale_color_manual(values=plt.cols.short) +scale_y_continuous(limits=c(0,500))+scale_x_continuous(limits=c(2010,2060))+
  ggtitle("TulipTree Biomass") +theme(plot.title = element_text(size=30, margin = margin(t = 10, b = -20), hjust=0.1)) +xlab("Time")+ylab("Aboveground biomass (g/m2)") + theme(legend.key.width=unit(1.5,"cm"))
ggsave(output.plot.Tulip, filename = png_name, width=11, height=8.5, units="in")
# dev.


  
list.files(output_dir)
  
  