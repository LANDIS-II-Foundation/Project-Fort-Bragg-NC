################## SUMMARIZE MAPS FROM LANDIS-II RUNS #####################
########################## Summarizes across multiple LANDIS-II scenarios  ################################
#################################Created by M. Lucash, adapted from M. Creutzburg's file

library(ggplot2)
# library(gridExtra)
# library(gridGraphics)
library(png)
# library(plyr)


# Set working directory
dir <- "C:/PSU/New_Run/"
setwd(dir)

# output_dir<-("C:/Users/msluc/Documents/DoD/Poster_sims/Graphs/")
output_dir <- "C:/PSU/GCC/4_Corner/Graphs/"

# Set up empty objects
no_reps <- 1  # input nummber of replicates here

#scen_file <- read.csv ("LUT_ResilienceScenarios_05.23.19.csv")
#scen_list<-scen_file[,1]

# List out scenario folder names in scenario_list object. Only use non-Adapt scenarios
# scen_list <- c("Historical","4.5","8.5")
scen_list <- c("Disturbance_Testing_GCC_Num_2_071519","Disturbance_Testing_GCC_Num_20_071519",
               "Disturbance_Testing_Historic_071619")
#number_scenarios<-length(scen_list)

# Load lookup tables for joining to data.  

Year_LUT <- read.csv ("C:/PSU/GCC/4_Corner/LUT_Year_1y.csv")
Year_LUT_50y <- Year_LUT[1:51,]
#Year_LUT <- read.csv ("C:/Users/lucash/Documents/ViFF_Runs/LUT_Time.csv")
Time_unique<-Year_LUT[1:51,"Time"]



##################################Output Species Biomass Loop#############################
#Now I read in all the LANDIS maps.  For species looping, I used the truncated species name (8 letters) because it matches the filenames in LANDIS.
all_data <- NULL
for (Scenario in scen_list)   # for each scenario and replicate, compiles data into a single data frame
{
  for (i in 1:no_reps)
  {
    #log_file <- paste(dir, Scenario, "/", "replicate", i, "/", "Century-succession-log.csv", sep="")
    log_file <- paste(dir, Scenario, "/", "scrapple-summary-log.csv", sep="")
    log_data <- read.csv(log_file)
    select_data <- (log_data[,c(1:13)])  # select the column numbers of interest
    replicate <- rep(i, nrow(select_data))         # create a vector of the length of your input file to record the replicate using the rep (replicate) function
    reps_data <- cbind(select_data, replicate)     # bind the replicate number to the data
    scenar <- rep(Scenario, nrow(select_data))     # create a vector of the length of your input file to record the scenario using the rep (replicate) function
    scen_data <- cbind(reps_data, Scenario)        # bind the scenario name to the data
    all_data <- rbind(all_data, scen_data)         # append the replicates together
  }
}
tail(all_data)
#If it's helpful to merge by a scenario name
#all_data1 <- merge(all_data, Scenario_LUT, by.x="Scenario", by.y="Scenario_path")

all_data2 <- merge(all_data, Year_LUT_50y, by.x="SimulationYear", by.y="Time", all=TRUE)
#Creates an output file in this directory= K:\Research_Faculty\AFRI_Chippewa_Project\Output_From_Sims

#Somehow I'm getting a NA scenario that I have to remove.  ANNOYING!!
Final_data<-subset(all_data2, all_data2$SimulationYear > 0)
                   # %in% "Historical" | all_data2$Scenario %in% "4.5" | all_data2$Scenario %in% "8.5")
head(Final_data)

tail(Final_data)
# plt.cols.short <- c("#000000", "#E69F00", "#D55E00") #Number corresponds to scenarios
plt.cols.short <- c("orange", "blue","black")

#Graph for Rx fire sites for all scenarios
# dev.off()
  png_name<-paste(output_dir, "Rx_Extent_vs_Time_071619.png", sep="")
  output.plot.v1<-ggplot(Final_data, aes(x=Year, y= TotalBurnedSitesRx, color=Scenario)) +  geom_line(size=1.5) + scale_color_manual(values=plt.cols.short)+scale_y_continuous(limits=c(4000,15000))+scale_x_continuous((limits=c(0,50)))
  output.plot.v2<-output.plot.v1+theme_classic()+ggtitle("Presciption Burning") +theme(plot.title = element_text(hjust=0.5)) + labs(colour="Climate Scenario")+xlab("Time")+ylab("Hectares burned") + theme(legend.position = "right")
  
  ggsave(output.plot.v2, filename = png_name, width=11, height=8.5, units="in")
  # dev.off()
  
  