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

# List out scenario folder names in scenario_list object. 
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
    log_file <- paste(dir, ScenarioName, "/", "NECN-succession-log.csv", sep="")
    log_data <- read.csv(log_file)
    select_data <- (log_data[,c(1:61)])  # select the column numbers of interest
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


head(all_data2)
# plt.cols.short <- c("#000000", "#E69F00", "#D55E00") #Number corresponds to scenarios
plt.cols.short <- c("#E69F00", "#009E73", "#F0E442", "#56B4E9", "#D55E00","#0072B2", "#E69F00", "#009E73", "#F0E442", "#56B4E9", "#D55E00","#0072B2")


#Graph for all species together on one graph
# dev.off()
  png_name<-paste(output_dir, "Biomass_vs_Time_071619.png", sep="")
  
  output.plot.v1<-ggplot(all_data2, aes(x=Year, y= AGB, group = as.factor(Scenarios)))+ theme_classic()+ geom_line(aes(linetype = Scenarios, color = Scenarios), size=1.3) + scale_linetype_manual(values=c("solid", "solid", "solid", "solid", "solid", "solid", "dashed", "dashed", "dashed", "dashed", "dashed", "dashed"))+scale_color_manual(values=plt.cols.short) +scale_y_continuous(limits=c(0,30000))+scale_x_continuous(limits=c(2010,2060))+
  ggtitle("Overall Trends in Biomass") +theme(plot.title = element_text(size=30, margin = margin(t = 10, b = -20), hjust=0.1)) +xlab("Time")+ylab("Aboveground biomass (g/m2)") + theme(legend.key.width=unit(1.5,"cm"))


  ggsave(output.plot.v1, filename = png_name, width=11, height=8.5, units="in")
  # dev.off()
  
#Graph of ANPP

final_data<- subset(all_data2, all_data2$Time >0)

png_name<-paste(output_dir, "ANPP_vs_Time_071619.png", sep="")

output.plot.v2<-ggplot(final_data, aes(x=Year, y= AG_NPPC, group = as.factor(Scenarios)))+ theme_classic()+ geom_line(aes(linetype = Scenarios, color = Scenarios), size=1.3) + scale_linetype_manual(values=c("solid", "solid", "solid", "solid", "solid", "solid", "dashed", "dashed", "dashed", "dashed", "dashed", "dashed"))+scale_color_manual(values=plt.cols.short) +scale_y_continuous(limits=c(200,1200))+scale_x_continuous(limits=c(2010,2060))+
  ggtitle("Overall Trends in ANPP") +theme(plot.title = element_text(size=30, margin = margin(t = 10, b = -20), hjust=0.1)) +xlab("Time")+ylab("Aboveground biomass (g/m2)") + theme(legend.key.width=unit(1.5,"cm"))
ggsave(output.plot.v2, filename = png_name, width=11, height=8.5, units="in")
# dev.off()



  list.files(output_dir)
  
  