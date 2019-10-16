################## SUMMARIZE MAPS FROM LANDIS-II RUNS #####################
########################## Summarizes across multiple LANDIS-II scenarios  ################################
#################################Created by M. Lucash, adapted from M. Creutzburg's file

# Load libraries
library(rgdal)   #Needed for rasters
library(raster)  #Needed for rasters
library(plotrix) #Needed for SE

#Determined from log file
active_cells<-53710

# Set working directory
dir <- "I:/Research/Shares/lucash_lab/Lucash/DoD_Model_Comparison/Output/PnET_BiomassMaps/"
setwd(dir)

output_dir<-("I:/Research/Shares/lucash_lab/Lucash/DoD_Model_Comparison/Output/PnET_BiomassMaps/Outputs/")

# Set up empty objects
no_reps <- 1  # input nummber of replicates here

#Scenario_LUT <- read.csv ("Scenarios_071919.csv")
#scen_list<-Scenario_LUT[,1]

# Used for testing only. Use Scenario look up table above.
scen_list <- c("Inputs")

# Load lookup tables for joining to data.  

Year_LUT <- read.csv ("I:/Research/Shares/lucash_lab/Lucash/VIFF/Output_R_Analysis/LookUpTables/LUT_Year_1y.csv")
Time_unique<-Year_LUT[c(0:51),"Time"]  #Use this if the sim didn't run the full 100 years.


##################################Output Species Biomass Loop#############################
#Now I read in all the LANDIS maps.  For species looping, I used the truncated species name (8 letters) because it matches the filenames in LANDIS.
spp_file<-read.csv("Spp_Functional_Crosswalk.csv")
spplist<-spp_file[,1]

#Set up a null matrix
LANDIS_spp_output_matrix<-NULL
for (scenario in 1:length(scen_list)) {
  each_scenario<-(scen_list[scenario])
    
for (m in 1:length(Time_unique)){   # for each scenario and replicate, compiles data into a single data frame  
  each_time<-(Time_unique[m])
  
for (s in 1:length(spplist)){#for each species...
  each_spp<-(spplist[s])
  spp_LANDIS_all<-as.data.frame(raster(paste(dir,each_scenario, "/biomass/",each_spp,"-", each_time,".img",sep="")))#LANDIS unique spp biomass.
  #spp_LANDIS_all<-((paste(dir,each_scenario,"/", each_spp,"-", each_time,".img",sep="")))#LANDIS unique spp biomass.
  colnames(spp_LANDIS_all)<-c("LANDIS_Biomass")
  spp_LANDIS_all[is.na(spp_LANDIS_all)]<-0 
  spp_LANDIS<-subset(spp_LANDIS_all, spp_LANDIS_all$LANDIS_Biomass>0)
  avg_biomass<-mean(as.numeric(spp_LANDIS$LANDIS))   #Units of g/m2
  extent <-length(as.numeric(spp_LANDIS$LANDIS))  #Total hectares of each species
  Total_biomass <-avg_biomass*extent #Total hectares of each species
  avg_landscape_biomass<-Total_biomass/active_cells
  SE_avg_biomass <-std.error(as.numeric(spp_LANDIS$LANDIS))
  LANDIS_spp_output_row<-cbind.data.frame(each_scenario, each_time, each_spp, avg_landscape_biomass, extent, SE_avg_biomass)
  LANDIS_spp_output_matrix<-rbind(LANDIS_spp_output_matrix, LANDIS_spp_output_row)
  } #closes species loop
} #closes time loop
} #closes scenario loop
colnames(LANDIS_spp_output_matrix)<-c("ScenarioName", "Time", "Species", "Avg_Biomass_gm2", "Extent_ha", "SE_AvgBiomass")

head(LANDIS_spp_output_matrix)
tail(LANDIS_spp_output_matrix)

write.csv(LANDIS_spp_output_matrix, file=paste(output_dir, "SppBiomass-Summary-manyParms.csv", sep=""))

JustBiomass <- LANDIS_spp_output_matrix[,c(1:4)]
head(JustBiomass)

write.csv(JustBiomass, file=paste(output_dir, "SppBiomass-Summary.csv", sep=""))



