# Laing-Bergelson-Infancy
Code for Laing &amp; Bergelson (forthcoming)

***Laing-BergelsonInfancy.Rproj*** contains the full set of scripts for this publication.

**Data used in the analysis (saved in '/data')**

 - **17_month_ages.csv**: infants' age in days at time of CDI and demographics data collection (6m and 18m), audio recording, and video recording. DOBs have been removed from this dataset.
 - **Demo_deid_cleaned.csv**: full demographics data from the SEEDLINGS dataset, coded according to a key. Relevant aspects of the key are included in the Demographics.R script
 - **ParentPVT.csv**: mothers' PVT data taken at 6m. This also includes mothers' age at this time-point.
 - **workstudy_data.feather**: infant production data; this includes CDI data, and noun types and tokens produced in the video and audio data
 
**Scripts used in the analysis**

- **Demographics.R:** This script pulls together demographics data from Demo_deid_cleaned.csv and ParentPVT.csv, and merges this with workstudy_data.feather. This includes variables used in the analysis (mothers' work status at 6m and 18m, mothers' work hours at 6m and 18m, mothers' education, sex), and data included in the supplementary materials (number of siblings, household income, fathers' work status). Data is then joined with workstudy_data.feather to include CDI vocabulary, types and tokens at 17m.
- **Laing-BergelsonInfancy.R:** This script runs the analysis that generates the results for the Laing & Bergelson (in press) study.

**Bayes analysis in JASP**

**workdata.csv** is generated for analysis in Laing-BergelsonInfancy.R. This is saved to **/data** to allow Bayesian analysis in JASP. For this analysis we conducted a Bayesian ANOVA, with sex and mother's education/PVT score included in the null model. **JASP_ANOVAs.html** shows the output from this analysis.
 
It is not currently possible to run t-tests on variables with more than 2 factors in JASP. The following three files in **/data** are created within Laing-BergelsonInfancy.R. The *caretype* variable is filtered to generate three sets of data for comparison:

- **noFullbayes.csv:** workdata.csv is filtered to include only 'Home-only' and 'Mixed-care' in the *caretype* variable
- **noHomebayes.csv:** workdata.csv is filtered to include only 'Care-only' and 'Mixed-care' in the *caretype* variable
- **noMixedbayes.csv:** workdata.csv is filtered to include only 'Home-only' and 'Care-only' in the *caretype* variable

These three sets of data are used to generate Bayes factors for Bayesian independent samples t-tests in JASP. These generate the following output:

- **JASP_ttest_Home-vs-Mixed.html:** output from Bayesian t-test with noFullbayes.csv
- **JASP_ttest_Mixed-vs-Care.html:** output from Bayesian t-test with noHomebayes.csv
- **JASP_ttest_Care-vs-Home.html:** output from Bayesian t-test with noMixedbayes.csv





