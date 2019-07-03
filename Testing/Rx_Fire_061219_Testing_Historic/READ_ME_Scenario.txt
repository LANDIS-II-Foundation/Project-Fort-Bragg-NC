Using Historic weather drivers, with both harvest and SCRAPPLE models running.

"Rx_Fire_061219_Testing_Historic"
	ClimateTimeSeries - Daily_RandomYears

climate-generator-baseline.txt
	ClimateTimeSeries - Daily_RandomYears
	ClimateFile - FortBragg_New_Climate_With_WD_noSWR.csv
	InitialCommunities - ./Ft.Bragg_IC_File.txt

scenario_FB.txt
	"NECN Succession" NECNSuccession_FortBragg_v3.txt
	"SCRAPPLE" SCRAPPLE_FB053019.txt
	"Output Biomass Reclass" output-biomass-reclass.txt
	"Output Biomass" output-biomass.txt

FB_Harvest_BAU_042519-0612.txt