################## SUMMARIZE MAPS FROM LANDIS-II RUNS #####################
########################## Summarizes across multiple LANDIS-II scenarios  ################################
#################################Created by M. Lucash, adapted from M. Creutzburg's file

library(ggplot2)
# library(gridExtra)
# library(gridGraphics)
library(png)
library(dplyr)


# Set working directory
dir <- "C:/Users/mslucash/Documents/DoD/"
setwd(dir)

output_dir<-("C:/Users/mslucash/Documents/DoD/")
#output_dir <- "C:/PSU/GCC/4_Corner/Graphs/"

# Set up empty objects
no_reps <- 1  # input nummber of replicates here

Scenario_LUT <- read.csv ("Scenarios_071919.csv")
scen_list<-Scenario_LUT[,1]

# List out scenario folder names in scenario_list object. 
# scen_list <- c("Disturbance_Testing_GCC_Num_2_071519","Disturbance_Testing_GCC_Num_20_071519",
#                "Disturbance_Testing_Historic_071619")
# scen_list <- c("Disturbance_Testing_GCC_Num_2_071519","Disturbance_Testing_GCC_Num_20_071519",
#                "Disturbance_Testing_PnET_GCC_Num_2_071519","Disturbance_Testing_PnET_GCC_Num_20_071519")


# Load lookup tables for joining to data.  
Year_LUT <- read.csv (paste(dir, "LUT_Year_1y.csv", sep=""))
Year_LUT_50y <- Year_LUT[2:51,]
#Year_LUT <- read.csv ("C:/Users/lucash/Documents/ViFF_Runs/LUT_Time.csv")



##################################RX fire  Loop#############################
#Now I read in all the csv files.  For species looping,
all_data <- NULL
for (ScenarioName in scen_list)   # for each scenario and replicate, compiles data into a single data frame
{
  for (i in 1:no_reps)
  {
    #log_file <- paste(dir, Scenario, "/", "replicate", i, "/", "Century-succession-log.csv", sep="")
    log_file <- paste(dir, ScenarioName, "/", "scrapple-summary-log.csv", sep="")
    log_data <- read.csv(log_file)
    select_data <- (log_data[,c(1:13)])  # select the column numbers of interest
    replicate <- rep(i, nrow(select_data))         # create a vector of the length of your input file to record the replicate using the rep (replicate) function
    reps_data <- cbind(select_data, replicate)     # bind the replicate number to the data
    scenar <- rep(ScenarioName, nrow(select_data))     # create a vector of the length of your input file to record the scenario using the rep (replicate) function
    scen_data <- cbind(reps_data, ScenarioName)        # bind the scenario name to the data
    all_data <- rbind(all_data, scen_data)         # append the replicates together
  }
}
head(all_data)
#If it's helpful to merge by a scenario name
all_data1 <- merge(all_data, Scenario_LUT, by.x="ScenarioName", by.y="Folder")

Final_data <- merge(all_data1, Year_LUT_50y, by.x="SimulationYear", by.y="Time", all=TRUE)
#Creates an output file in this directory= K:\Research_Faculty\AFRI_Chippewa_Project\Output_From_Sims

# #Somehow I'm getting a NA scenario that I have to remove.  ANNOYING!!
# Final_data<-subset(all_data2, all_data2$SimulationYear > 0)
#                    # %in% "Historical" | all_data2$Scenario %in% "4.5" | all_data2$Scenario %in% "8.5")
head(Final_data)

tail(Final_data)


# plt.cols.short <- c("#000000", "#E69F00", "#D55E00") #Number corresponds to scenarios
plt.cols.short <- c("#E69F00", "#009E73", "#F0E442", "#56B4E9", "#D55E00","#0072B2", "#E69F00", "#009E73", "#F0E442", "#56B4E9", "#D55E00","#0072B2")

#Graph for Rx fire sites for all scenarios. Area first.
# dev.off()
  png_name<-paste(output_dir, "Rx_Extent_vs_Time_071919.png", sep="")
  output.plot.v1<-ggplot(Final_data, aes(x=Year, y= TotalBurnedSitesRx, group = as.factor(Scenarios)))+ theme_classic()+ geom_line(aes(linetype = Scenarios, color = Scenarios), size=1.3) + scale_linetype_manual(values=c("solid", "solid", "solid", "solid", "solid", "solid", "dashed", "dashed", "dashed", "dashed", "dashed", "dashed"))+scale_color_manual(values=plt.cols.short) +scale_y_continuous(limits=c(3000,15000))+scale_x_continuous(limits=c(2010,2060))+
ggtitle("Prescription Burning") +theme(plot.title = element_text(size=30, margin = margin(t = 10, b = -20), hjust=0.1)) +xlab("Time")+ylab("Hectares burned") + theme(legend.key.width=unit(1.5,"cm"))
output.plot.v1

  ggsave(output.plot.v1, filename = png_name, width=11, height=8.5, units="in")

dev.off()

png_name<-paste(output_dir, "NumberFires_vs_Time_071919.png", sep="")
output.plot.v2<-ggplot(Final_data, aes(x=Year, y= NumberFiresRx, group = as.factor(Scenarios)))+ theme_classic()+geom_line(aes(linetype = Scenarios, color = Scenarios), size=1.3) + scale_linetype_manual(values=c("solid", "solid", "solid", "solid", "solid", "solid", "dashed", "dashed", "dashed", "dashed", "dashed", "dashed"))+scale_color_manual(values=plt.cols.short) +scale_y_continuous(limits=c(0,300))+scale_x_continuous(limits=c(2010,2060))+
  ggtitle("Prescription Burning") +theme(plot.title = element_text(size=30, margin = margin(t = 10, b = -20), hjust=0.1)) +xlab("Time")+ylab("Number of Fires") + theme(legend.key.width=unit(1.5,"cm"))
output.plot.v2

ggsave(output.plot.v2, filename = png_name, width=11, height=8.5, units="in")

png_name<-paste(output_dir, "Fire_BiomassMortality_vs_Time_071919.png", sep="")
output.plot.v3<-ggplot(Final_data, aes(x=Year, y= TotalBiomassMortalityRx, group = as.factor(Scenarios)))+ theme_classic()+geom_line(aes(linetype = Scenarios, color = Scenarios), size=1.3) + scale_linetype_manual(values=c("solid", "solid", "solid", "solid", "solid", "solid", "dashed", "dashed", "dashed", "dashed", "dashed", "dashed"))+scale_color_manual(values=plt.cols.short) +scale_y_continuous(limits=c(50000, 3500000))+scale_x_continuous(limits=c(2010,2060))+
  ggtitle("Prescription Burning") +theme(plot.title = element_text(size=30, margin = margin(t = 10, b = -20), hjust=0.1)) +xlab("Time")+ylab("Biomass Removed by Fire") + theme(legend.key.width=unit(1.5,"cm"))
output.plot.v3

ggsave(output.plot.v3, filename = png_name, width=11, height=8.5, units="in")
  
  