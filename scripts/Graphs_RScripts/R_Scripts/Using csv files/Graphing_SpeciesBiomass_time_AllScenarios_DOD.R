################## SUMMARIZE MAPS FROM LANDIS-II RUNS #####################
########################## Summarizes across multiple LANDIS-II scenarios  ################################
#################################Created by M. Lucash, adapted from M. Creutzburg's file


library(ggplot2)
# library(gridExtra)
# library(gridGraphics)
 library(png)
# library(plyr)


# Set working directory
dir <- "C:/Users/mslucash/Documents/DoD/"
setwd(dir)

output_dir<-("C:/Users/mslucash/Documents/DoD/")

# Set up empty objects
no_reps <- 1  # input nummber of replicates here

Scenario_LUT <- read.csv ("Scenarios_071919.csv")
scen_list<-Scenario_LUT[,1]

# List out scenario folder names in scenario_list object. Only use non-Adapt scenarios
# scen_list <- c("Historical","4.5","8.5")
# scen_list <- c("Disturbance_Testing_GCC_Num_2_071519","Disturbance_Testing_GCC_Num_20_071519",
#                "Disturbance_Testing_Historic_071619","No-Disturbance_Testing_Historic_071619",
#                "No-Disturbance_Testing_GCC_Num_2_071519","No-Disturbance_Testing_GCC_Num_20_071519")



#number_scenarios<-length(scen_list)

# Load lookup tables for joining to data.  
Year_LUT <- read.csv (paste(dir, "LUT_Year_1y.csv", sep=""))
Year_LUT_50y <- Year_LUT[1:51,]


##################################Output Species Biomass Loop#############################
#Now I read in all the LANDIS maps.  For species looping, I used the truncated species name (8 letters) because it matches the filenames in LANDIS.
all_data <- NULL
for (ScenarioName in scen_list)   # for each scenario and replicate, compiles data into a single data frame
{
  for (i in 1:no_reps)
  {
    #log_file <- paste(dir, Scenario, "/", "replicate", i, "/", "Century-succession-log.csv", sep="")
    log_file <- paste(dir, ScenarioName, "/", "spp-biomass-log.csv", sep="")
    log_data <- read.csv(log_file)
    select_data <- (log_data[,c(1:12)])  # select the column numbers of interest
    replicate <- rep(i, nrow(select_data))         # create a vector of the length of your input file to record the replicate using the rep (replicate) function
    reps_data <- cbind(select_data, replicate)     # bind the replicate number to the data
    scenar <- rep(ScenarioName, nrow(select_data))     # create a vector of the length of your input file to record the scenario using the rep (replicate) function
    scen_data <- cbind(reps_data, ScenarioName)        # bind the scenario name to the data
    all_data <- rbind(all_data, scen_data)         # append the replicates together
  }
}
tail(all_data)
#If it's helpful to merge by a scenario name
all_data1 <- merge(all_data, Scenario_LUT, by.x="ScenarioName", by.y="Folder")

all_data2 <- merge(all_data1, Year_LUT_50y, by.x="Time", by.y="Time", all=TRUE)

FortBragg_data<-subset(all_data2, all_data2$EcoName %in% " FortBragg")


head(FortBragg_data)


#plt.cols.short <- c("blue", "orange", "black","gray","darkslateblue","orangered")
plt.cols.short <- c("#E69F00", "#009E73", "#F0E442", "#56B4E9", "#D55E00","#0072B2", "#E69F00", "#009E73", "#F0E442", "#56B4E9", "#D55E00","#0072B2")


#Graph for all scenarios for Loblolly
  png_name<-paste(output_dir, "LoblollyBiomass_vs_Time_071919.png", sep="")
  output.plot.Lob<-ggplot(FortBragg_data, aes(x=Year, y= AboveGroundBiomass_LobPine, group = as.factor(Scenarios)))+ theme_classic()+ geom_line(aes(linetype = Scenarios, color = Scenarios), size=1.3) + scale_linetype_manual(values=c("solid", "solid", "solid", "solid", "solid", "solid", "dashed", "dashed", "dashed", "dashed", "dashed", "dashed"))+scale_color_manual(values=plt.cols.short) +scale_y_continuous(limits=c(0,10000))+scale_x_continuous(limits=c(2010,2060))+
  ggtitle("Loblolly Biomass") +theme(plot.title = element_text(size=30, margin = margin(t = 10, b = -20), hjust=0.1)) +xlab("Time")+ylab("Aboveground biomass (g/m2)") + theme(legend.key.width=unit(1.5,"cm"))
  ggsave(output.plot.Lob, filename = png_name, width=11, height=8.5, units="in")
  # dev.off()
  
  #Graph for all scenarios for Longleaf
  png_name<-paste(output_dir, "LongleafBiomass_vs_Time_071919.png", sep="")
  output.plot.Long<-ggplot(FortBragg_data, aes(x=Year, y= AboveGroundBiomass_LongleafPine, group = as.factor(Scenarios)))+ theme_classic()+ geom_line(aes(linetype = Scenarios, color = Scenarios), size=1.3) + scale_linetype_manual(values=c("solid", "solid", "solid", "solid", "solid", "solid", "dashed", "dashed", "dashed", "dashed", "dashed", "dashed"))+scale_color_manual(values=plt.cols.short) +scale_y_continuous(limits=c(0,15000))+scale_x_continuous(limits=c(2010,2060))+
  ggtitle("Longleaf Biomass") +theme(plot.title = element_text(size=30, margin = margin(t = 10, b = -20), hjust=0.1)) +xlab("Time")+ylab("Aboveground biomass (g/m2)") + theme(legend.key.width=unit(1.5,"cm"))
  ggsave(output.plot.Long, filename = png_name, width=11, height=8.5, units="in")
  # dev.off()

  #Graph for all scenarios for SweetGum
  png_name<-paste(output_dir, "SweetGumBiomass_vs_Time_071919.png", sep="")
  output.plot.Sweet<-ggplot(FortBragg_data, aes(x=Year, y= AboveGroundBiomass_SweetGum, group = as.factor(Scenarios)))+ theme_classic()+ geom_line(aes(linetype = Scenarios, color = Scenarios), size=1.3) + scale_linetype_manual(values=c("solid", "solid", "solid", "solid", "solid", "solid", "dashed", "dashed", "dashed", "dashed", "dashed", "dashed"))+scale_color_manual(values=plt.cols.short) +scale_y_continuous(limits=c(0,500))+scale_x_continuous(limits=c(2010,2060))+
  ggtitle("Sweetgum Biomass") +theme(plot.title = element_text(size=30, margin = margin(t = 10, b = -20), hjust=0.1)) +xlab("Time")+ylab("Aboveground biomass (g/m2)") + theme(legend.key.width=unit(1.5,"cm"))
  ggsave(output.plot.Sweet, filename = png_name, width=11, height=8.5, units="in")
  # dev.off()  

#Graph for all scenarios for Shortpine
png_name<-paste(output_dir, "ShortPineBiomass_vs_Time_071919.png", sep="")
output.plot.Short<-ggplot(FortBragg_data, aes(x=Year, y= AboveGroundBiomass_ShortPine, group = as.factor(Scenarios)))+ theme_classic()+ geom_line(aes(linetype = Scenarios, color = Scenarios), size=1.3) + scale_linetype_manual(values=c("solid", "solid", "solid", "solid", "solid", "solid", "dashed", "dashed", "dashed", "dashed", "dashed", "dashed"))+scale_color_manual(values=plt.cols.short) +scale_y_continuous(limits=c(0,200))+scale_x_continuous(limits=c(2010,2060))+
  ggtitle("Short Pine Biomass") +theme(plot.title = element_text(size=30, margin = margin(t = 10, b = -20), hjust=0.1)) +xlab("Time")+ylab("Aboveground biomass (g/m2)") + theme(legend.key.width=unit(1.5,"cm"))
ggsave(output.plot.Short, filename = png_name, width=11, height=8.5, units="in")
# dev.off()  

#Graph for all scenarios for Slash
png_name<-paste(output_dir, "SlashBiomass_vs_Time_071919.png", sep="")
output.plot.Slash<-ggplot(FortBragg_data, aes(x=Year, y= AboveGroundBiomass_SlashPine, group = as.factor(Scenarios)))+ theme_classic()+ geom_line(aes(linetype = Scenarios, color = Scenarios), size=1.3) + scale_linetype_manual(values=c("solid", "solid", "solid", "solid", "solid", "solid", "dashed", "dashed", "dashed", "dashed", "dashed", "dashed"))+scale_color_manual(values=plt.cols.short) +scale_y_continuous(limits=c(0,500))+scale_x_continuous(limits=c(2010,2060))+
  ggtitle("Slash Pine Biomass") +theme(plot.title = element_text(size=30, margin = margin(t = 10, b = -20), hjust=0.1)) +xlab("Time")+ylab("Aboveground biomass (g/m2)") + theme(legend.key.width=unit(1.5,"cm"))
ggsave(output.plot.Slash, filename = png_name, width=11, height=8.5, units="in")
# dev.off()  

#Graph for all scenarios for WhiteOak
png_name<-paste(output_dir, "WhiteOakBiomass_vs_Time_071919.png", sep="")
output.plot.WhiteOak<-ggplot(FortBragg_data, aes(x=Year, y= AboveGroundBiomass_WhiteOak, group = as.factor(Scenarios)))+ theme_classic()+ geom_line(aes(linetype = Scenarios, color = Scenarios), size=1.3) + scale_linetype_manual(values=c("solid", "solid", "solid", "solid", "solid", "solid", "dashed", "dashed", "dashed", "dashed", "dashed", "dashed"))+scale_color_manual(values=plt.cols.short) +scale_y_continuous(limits=c(0,300))+scale_x_continuous(limits=c(2010,2060))+
  ggtitle("White Oak Biomass") +theme(plot.title = element_text(size=30, margin = margin(t = 10, b = -20), hjust=0.1)) +xlab("Time")+ylab("Aboveground biomass (g/m2)") + theme(legend.key.width=unit(1.5,"cm"))
ggsave(output.plot.WhiteOak, filename = png_name, width=11, height=8.5, units="in")
# dev.off()  

#Graph for all scenarios for WhiteOak
png_name<-paste(output_dir, "TurkeyOakBiomass_vs_Time_071919.png", sep="")
output.plot.TurkeyOak<-ggplot(FortBragg_data, aes(x=Year, y= AboveGroundBiomass_TurkeyOak, group = as.factor(Scenarios)))+ theme_classic()+ geom_line(aes(linetype = Scenarios, color = Scenarios), size=1.3) + scale_linetype_manual(values=c("solid", "solid", "solid", "solid", "solid", "solid", "dashed", "dashed", "dashed", "dashed", "dashed", "dashed"))+scale_color_manual(values=plt.cols.short) +scale_y_continuous(limits=c(0,300))+scale_x_continuous(limits=c(2010,2060))+
  ggtitle("Turkey Oak Biomass") +theme(plot.title = element_text(size=30, margin = margin(t = 10, b = -20), hjust=0.1)) +xlab("Time")+ylab("Aboveground biomass (g/m2)") + theme(legend.key.width=unit(1.5,"cm"))
ggsave(output.plot.TurkeyOak, filename = png_name, width=11, height=8.5, units="in")
# dev.off()  

#Graph for all scenarios for WhiteOak
png_name<-paste(output_dir, "RedMapleBiomass_vs_Time_071919.png", sep="")
output.plot.RedMaple<-ggplot(FortBragg_data, aes(x=Year, y= AboveGroundBiomass_RedMaple, group = as.factor(Scenarios)))+ theme_classic()+ geom_line(aes(linetype = Scenarios, color = Scenarios), size=1.3) + scale_linetype_manual(values=c("solid", "solid", "solid", "solid", "solid", "solid", "dashed", "dashed", "dashed", "dashed", "dashed", "dashed"))+scale_color_manual(values=plt.cols.short) +scale_y_continuous(limits=c(0,1000))+scale_x_continuous(limits=c(2010,2060))+
  ggtitle("Red Maple Biomass") +theme(plot.title = element_text(size=30, margin = margin(t = 10, b = -20), hjust=0.1)) +xlab("Time")+ylab("Aboveground biomass (g/m2)") + theme(legend.key.width=unit(1.5,"cm"))
ggsave(output.plot.RedMaple, filename = png_name, width=11, height=8.5, units="in")
# dev.off()  

#Graph for all scenarios for WhiteOak
png_name<-paste(output_dir, "TulipTreeBiomass_vs_Time_071919.png", sep="")
output.plot.Tulip<-ggplot(FortBragg_data, aes(x=Year, y= AboveGroundBiomass_TulipTree, group = as.factor(Scenarios)))+ theme_classic()+ geom_line(aes(linetype = Scenarios, color = Scenarios), size=1.3) + scale_linetype_manual(values=c("solid", "solid", "solid", "solid", "solid", "solid", "dashed", "dashed", "dashed", "dashed", "dashed", "dashed"))+scale_color_manual(values=plt.cols.short) +scale_y_continuous(limits=c(0,500))+scale_x_continuous(limits=c(2010,2060))+
  ggtitle("TulipTree Biomass") +theme(plot.title = element_text(size=30, margin = margin(t = 10, b = -20), hjust=0.1)) +xlab("Time")+ylab("Aboveground biomass (g/m2)") + theme(legend.key.width=unit(1.5,"cm"))
ggsave(output.plot.Tulip, filename = png_name, width=11, height=8.5, units="in")
# dev.
  
list.files(output_dir)
  
  