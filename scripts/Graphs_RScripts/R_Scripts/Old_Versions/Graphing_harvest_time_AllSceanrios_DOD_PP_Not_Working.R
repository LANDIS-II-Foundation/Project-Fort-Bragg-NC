################## SUMMARIZE MAPS FROM LANDIS-II RUNS #####################
########################## Summarizes across multiple LANDIS-II scenarios  ################################
#################################Created by M. Lucash, adapted from M. Creutzburg's file


library(ggplot2)
library(raster)  #Needed for rasters

# Set working directory
dir <- "C:/PSU/New_Run/"
setwd(dir)

#Set output directory
output_dir<-("C:/PSU/GCC/Outputs_Final_Report/")

# Set up empty objects
no_reps <- 1  # input nummber of replicates here

Scenario_LUT <- read.csv ("C:/PSU/GCC/R_files_Final/Scenarios_071919.csv")
scen_list<-Scenario_LUT[,1]


# List out scenario folder names in scenario_list object. Only use non-Adapt scenarios
# scen_list <- c("Historical","4.5","8.5")
#scen_list <- c("Disturbance_Testing_GCC_Num_2_071519","Disturbance_Testing_GCC_Num_20_071519", "Disturbance_Testing_Historic_071619")
#number_scenarios<-length(scen_list)
scen_list <- c("Disturbance_Testing_GCC_Num_2_071519/harvest","Disturbance_Testing_GCC_Num_20_071519/harvest",
        "Disturbance_Testing_PnET_GCC_Num_2_071519/harvest","Disturbance_Testing_PnET_GCC_Num_20_071519/harvest")

# Load lookup tables for joining to data.  
Year_LUT <- read.csv ("C:/PSU/GCC/R_files_Final/LUT_Year_1y.csv")
Year_LUT_50y <- Year_LUT[2:51,]


##################################Output Species Biomass Loop#############################
#Now I read in all the LANDIS maps.  For species looping, I used the truncated species name (8 letters) because it matches the filenames in LANDIS.
all_data <- NULL
for (ScenarioName in scen_list)   # for each scenario and replicate, compiles data into a single data frame
{
  for (i in 1:no_reps)
  {
    #log_file <- paste(dir, Scenario, "/", "replicate", i, "/", "Century-succession-log.csv", sep="")
    # log_file <- paste(dir, Scenario, "/", "summary-log.csv", sep="")
    #log_file <- paste(dir, Scenario, "/harvest/", "harvest-summary-log.csv", sep="")
    log_file <- paste(dir, ScenarioName, "/harvest-summary-log.csv", sep="")
    log_data <- read.csv(log_file)
    select_data <- (log_data[,c(-(8:17),-26)])  # select the column numbers of interest
    replicate <- rep(i, nrow(select_data))         # create a vector of the length of your input file to record the replicate using the rep (replicate) function
    reps_data <- cbind(select_data, replicate)     # bind the replicate number to the data
    scenar <- rep(ScenarioName, nrow(select_data))     # create a vector of the length of your input file to record the scenario using the rep (replicate) function
    scen_data <- cbind(reps_data, ScenarioName)        # bind the scenario name to the data
    all_data <- rbind(all_data, scen_data)         # append the replicates together
  }
}
tail(all_data)
head(all_data)
dim(all_data)
unique(all_data$ScenarioName)

all_data1 <- merge(all_data, Scenario_LUT, by.x="ScenarioName", by.y="Folder")

all_data2 <- merge(all_data1, Year_LUT_50y, by.x="Time", by.y="Time", all=TRUE)


plt.cols.short <- c("grey", "blue","yellow","orange")
# plt.cols.short <- c("#E69F00", "#009E73", "#F0E442", "#56B4E9", "#D55E00","#0072B2", "#E69F00", "#009E73", "#F0E442", "#56B4E9", "#D55E00","#0072B2")


# cbbPalette <- c("#000000", "#E69F00", "#56B4E9")
# 
# all_data3 <- all_data2
# colnms=c("BiomassHarvestedMg_LobPine", "BiomassHarvestedMg_LongleafPine", 
#          "BiomassHarvestedMg_ShortPine", "BiomassHarvestedMg_WhiteOak",
#          "BiomassHarvestedMg_TurkeyOak", "BiomassHarvestedMg_SweetGum",
#          "BiomassHarvestedMg_RedMaple", "BiomassHarvestedMg_TulipTree")
# 
# all_data3$TotalBiomassHarvested <- rowSums(all_data2[,colnms])
# head(all_data3)


Thinning_Only<-subset (all_data2, all_data3$Prescription %in% " Thinnning_Pines")
head(Thinning_Only)

#Graph for biomass harvest for all scenarios
# dev.off()
  png_name<-paste(output_dir, "HarvestedBiomass_vs_Time_071919.png", sep="")  
  output.plot.v1<-ggplot(Thinning_Only, aes(x=Year, y= TotalBiomassHarvested, group = as.factor(Scenarios)))+ theme_classic()+ geom_line(aes(linetype = Scenarios, color = Scenarios), size=1.3) + scale_linetype_manual(values=c("solid", "solid", "dashed", "dashed"))+scale_color_manual(values=plt.cols.short) +scale_y_continuous(limits=c(0,70000))+scale_x_continuous(limits=c(2010,2060))+
  ggtitle("Total Biomass Harvested") +theme(plot.title = element_text(size=30, margin = margin(t = 10, b = -20), hjust=0.1)) +xlab("Time")+ylab("Aboveground biomass removed by harvesting (g/m2)") + theme(legend.key.width=unit(1.5,"cm"))
  ggsave(output.plot.v1, filename = png_name, width=11, height=8.5, units="in")
  # dev.off()
  
  #Graph of harvested area for all scenarios
  # dev.off()
  png_name<-paste(output_dir, "HarvestedArea_vs_Time_071919.png", sep="")
  output.plot.v2<-ggplot(Thinning_Only, aes(x=Year, y= HarvestedSites, group = as.factor(Scenarios)))+ theme_classic()+ geom_line(aes(linetype = Scenarios, color = Scenarios), size=1.3) + scale_linetype_manual(values=c("solid", "solid", "solid", "solid", "solid", "solid", "dashed", "dashed", "dashed", "dashed", "dashed", "dashed"))+scale_color_manual(values=plt.cols.short) +scale_y_continuous(limits=c(900,1200))+scale_x_continuous(limits=c(2010,2060))+
  ggtitle("Total hectares Harvested") +theme(plot.title = element_text(size=30, margin = margin(t = 10, b = -20), hjust=0.1)) +xlab("Time")+ylab("Extent of Harvesting (ha)") + theme(legend.key.width=unit(1.5,"cm"))
  ggsave(output.plot.v2, filename = png_name, width=11, height=8.5, units="in")
  # dev.off()
  
