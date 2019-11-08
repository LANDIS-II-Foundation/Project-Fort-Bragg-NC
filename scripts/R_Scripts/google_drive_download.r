library("googledrive")
library("tidyverse")
replicates<-1:3

climates<-c("Sims_CC2_Hurricanes_101219", "Sims_CC20_Hurricanes_101219")
climate_nu<-c(2,20)
clim_names<-c("HAD", "BCC")
clim_codes<-c("Numb2_082219", "Num20_101219")
NECN_output<-"https://drive.google.com/drive/folders/1DFriQO85o4STbLkCApkzX35H_kCINIis"
NECN_folder<-drive_get(as_id(NECN_output))
NECN_folders<-drive_ls(NECN_folder)

for (C1 in 1: length (climates)){
  CL<-climates[C1]
  CL_nu<-climate_nu[C1]
  cl_name<-clim_names[C1]
  clim_code<-clim_codes[C1]
  print(cl_name)
  clim_folder<-subset(NECN_folders, NECN_folders$name==CL)
  clim_ID<-clim_folder$id
  clim_folder_replicates<-drive_get(as_id(clim_ID))
  clim_replicate_files<-drive_ls(clim_folder_replicates)
  for (R1 in 1:length (replicates)){
    print(R1)
    setwd(paste0("Y:/FBNC/FORT_BRAGG_OUTPUTS/SCENARIO_NECN_FIRE3_",cl_name,"_HURRICANE/replicate10015020190",R1,"/"))
    rep_name_climate<-paste0("Hur_GCC_",clim_code,"_rep",R1)
    rep_id<-subset(clim_replicate_files,clim_replicate_files==rep_name_climate)$id
    folder_files<-drive_ls(as_id(rep_id))
    community_id<-subset(folder_files, folder_files$name=="community.zip")$id
    if(length(community_id)==1){
      walk(community_id, ~drive_download(as_id(.x), overwrite=T))   
      unzip("community.zip", overwrite = T)}
    if(length(community_id)==0){
      community_id_unzip<-subset(folder_files, folder_files$name=="community")$id
      csv_files<-drive_ls(as_id(community_id_unzip))
      walk(csv_files$id, ~drive_download(as_id(.x), overwrite=T))  
      }
    
    }
    }
