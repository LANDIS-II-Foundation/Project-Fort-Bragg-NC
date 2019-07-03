Using GCC weather drivers, with both harvest and SCRAPPLE models running.

GCC = bcc-csm1-1-m_r1i1p1_rcp45

"Rx_Fire_061219_Testing_GCC_45"
	ClimateTimeSeries - Daily_SequencedYears

climate-generator-baseline.txt
	ClimateTimeSeries - Daily_RandomYears
	ClimateFile - bcc-csm1-1-m_r1i1p1_rcp45_mod.csv
	InitialCommunities - ./Ft.Bragg_IC_File.txt

scenario_FB.txt
	"NECN Succession" NECNSuccession_FortBragg_v3.txt
	"SCRAPPLE" SCRAPPLE_FB053019.txt
	"Output Biomass Reclass" output-biomass-reclass.txt
	"Output Biomass" output-biomass.txt

FB_Harvest_BAU_042519-0612.txt