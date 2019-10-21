rem Scenario is %1
rem Replicate number is %2
set workingdir=C:\C_LANDIS_OUTPUTS
set homedir=C:\LANDIS_INPUTS

if not exist %workingdir%\%1\replicate%2 mkdir %workingdir%\%1\replicate%2
C:
cd %workingdir%\%1\replicate%2
copy C:\LANDIS_INPUTS\%1.txt
rem "@echo" lines below write metadata text file to scenario folder to include version information.
@echo off
@echo LANDIS Model and Extensions Last Modified Dates:> landis_version_metadata.txt
@echo PnET Succession Extension DLL %PNET_DLL_DATE%>> landis_version_metadata.txt
@echo LandUse Plus 1.0 DLL %LANDUSE_PLUS_DLL_DATE%>> landis_version_metadata.txt
@echo Harvest 3.0 DLL %HARVEST_DLL_DATE%>> landis_version_metadata.txt
@echo Output PnET DLL %OUTPUT_PNET_DLL_DATE%>> landis_version_metadata.txt

call landis-ii-7 %1.txt 

C:
cd %homedir%

