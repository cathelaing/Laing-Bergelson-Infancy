# Laing-Bergelson-Infancy
Code for Laing &amp; Bergelson (forthcoming)

**Data used in the analysis (saved in '/data')**

 - **17_month_ages.csv**: infants' age in days at time of CDI and demographics data collection (6m and 18m), audio recording, and video recording
 - **Demo_deid_cleaned.csv**: full demographics data from the SEEDLINGS dataset, coded according to a key. Relevant aspects of the key are included in the Demographics.R script
 - **ParentPVT.csv**: mothers' PVT data taken at 6m. This also includes mothers' age at this time-point.
 - **workstudy_data.feather**: infant production data; this includes CDI data, and noun types and tokens produced in the video and audio data
 
***Scripts used in the analysis***

**Demographics.R:** This script pulls together demographics data from Demo_deid_cleaned.csv and ParentPVT.csv, and merges this with workstudy_data.feather. This includes variables used in the analysis (mothers' work status at 6m and 18m, mothers' work hours at 6m and 18m, mothers' education, sex), and data included in the supplementary materials (number of siblings, household income, fathers' work status).

Data is then joined with workstudy_data.feather to include CDI vocabulary, types and tokens at 17m.

This is the main data script script for Laing & Bergelson (forthcoming).


17_month_ages.csv shows dates at which infants came to the lab. DoBs have been removed from this version. days_CDI was copied over from the CDI 
spreadsheet in Seedlings/Compiled_Data

ParentPVT.csv shows moms' ages and PVT results
