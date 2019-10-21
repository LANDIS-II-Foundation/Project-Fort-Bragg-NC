 
 set rep_num1=100150201907
 set rep_num2=100150201908
 set rep_num3=100150201909
 set rep_num4=1001502019010




for %%a in ("C:/Program Files/LANDIS-II/v6/bin/extensions/Landis.Extension.Succession.BiomassPnET.dll") do set PNET_DLL_DATE=%%~ta
for %%a in ("C:/Program Files/LANDIS-II/v6/bin/extensions/Landis.Extension.LandUse-1.0.dll") do set LANDUSE_PLUS_DLL_DATE=%%~ta
for %%a in ("C:/Program Files/LANDIS-II/v6/bin/extensions/Landis.Extension.BiomassHarvest-3.0.dll") do set HARVEST_DLL_DATE=%%~ta
for %%a in ("C:/Program Files/LANDIS-II/v6/bin/extensions/Landis.Extension.Output.PnET.dll") do set OUTPUT_PNET_DLL_DATE=%%~ta
set name=SCENARIO_PNET_FIRE3_HAD_HURRICANE



TITLE %name% R: %rep_num1%  %rep_num2%  %rep_num3%  %rep_num4%  MLM:,%PNET_DLL_DATE%

for %%i in (%rep_num1% %rep_num2% %rep_num3% %rep_num4%) do call C_to_C_helprun %name% %%i
rem for %%i in (%rep_num%) do call Server_helprun %name% %%i

pause
