

 set rep_num3=100150201904
 set rep_num4=100150201905
 set rep_num5=100150201906
 set rep_num6=100150201907
 set rep_num7=100150201908
 set rep_num8=100150201909
 set rep_num9=1001502019010
 set rep_num10=100150201901
 
for %%a in ("C:/Program Files/LANDIS-II/v6/bin/extensions/Landis.Extension.Succession.BiomassPnET.dll") do set PNET_DLL_DATE=%%~ta
for %%a in ("C:/Program Files/LANDIS-II/v6/bin/extensions/Landis.Extension.LandUse-1.0.dll") do set LANDUSE_PLUS_DLL_DATE=%%~ta
for %%a in ("C:/Program Files/LANDIS-II/v6/bin/extensions/Landis.Extension.BiomassHarvest-3.0.dll") do set HARVEST_DLL_DATE=%%~ta
for %%a in ("C:/Program Files/LANDIS-II/v6/bin/extensions/Landis.Extension.Output.PnET.dll") do set OUTPUT_PNET_DLL_DATE=%%~ta
set name=SCENARIO_PNET_FIRE3_BCC_HURRICANE




TITLE %name% R: %rep_num3%  %rep_num4%  %rep_num5%  %rep_num6%  %rep_num7%  %rep_num8%  %rep_num9%  %rep_num10%  MLM:,%PNET_DLL_DATE%

for %%i in (%rep_num3% %rep_num4% %rep_nun5% %rep_num6% %rep_num7% %rep_num8% %rep_num9% %rep_num10%) do call C_to_C_helprun %name% %%i

rem for %%i in (%rep_num%) do call Server_helprun %name% %%i
pause
