## Demographics gathering for Work Study: Updated 28th July 2018 ##

# This is the main file containing all demographics data, incorporating some data from the demographics questionnaires at 6 and 18 months,
# mothers' PVT scores, CDI data (productive vocabulary), and types and tokens produced in video recordings from 6-18 months.

# This is the first script to generate when arranging data for the work schedules analysis. 

# subj is a randomly-generated set of 3-digit numbers corresponding to original subject ids to preserve anonymity

library(tidyverse)
library(forcats)
library(feather)

# ParentPVT taken from data folder; copied on 26/07/18

PVT <- read_csv("data/ParentPVT.csv") %>% 
  dplyr::select(subj, age_mom, uncorrected_standard_score) %>%
  rename(PVTscore = uncorrected_standard_score)

## cdi.csv copied to working folder on 9/8/17

data <- read_feather("data/workstudy_data.feather") %>% 
  dplyr::select(subj, month, CDIprod, CDIcomp, noCDI, CDInounprod, CHI, CHItypes) %>%
  rename(CHItokens = CHI,
         CDI = CDIprod,
         CDInouns = CDInounprod) %>%
  mutate(Log.CDI = log(CDI+1),
         Log.CDIcomp = log(CDIcomp +1),
         Log.CDInouns = log(CDInouns+1),
         Log.Tokens = log(CHItokens+1),
         Log.Types = log(CHItypes+1))

## demo_deid_cleaned.csv copied to working folder on 6/1/17

workdata <- read_csv("data/demo_deid_cleaned.csv") %>%
  dplyr::select(                                                     
    subj,
    sex,
    maternal_education_18mos,
    maternal_employment_6mos,
    maternal_employment_18mos,
    maternal_employment_hours_6mos,
    maternal_employment_hours_18mos,
    paternal_employment_6mos,
    paternal_employment_18mos,
    paternal_employment_hours_18mos,
    family_income_18mos,
    family_income_6mos,
    adults_in_household_18mos,
    children_in_household_18mos_staff
  ) %>%
  dplyr::rename(MOTedu = maternal_education_18mos,  ## rename columns
                MOTwork6 = maternal_employment_6mos,
                MOTwork18 = maternal_employment_18mos,
                MOTworkhours6 = maternal_employment_hours_6mos,
                MOTworkhours18 = maternal_employment_hours_18mos,
                FATwork6 = paternal_employment_6mos,
                FATwork18 = paternal_employment_18mos,
                FATworkhours = paternal_employment_hours_18mos,
                HouseholdIncome6 = family_income_6mos,
                HouseholdIncome18 = family_income_18mos) %>%
  mutate(MOTedu = factor(MOTedu),  # rename variables according to Demo Key spreadsheet in Data folder
         MOTedu = fct_recode(MOTedu,
                             "High School" = "E",
                             "Some college" = "H",
                             "Assoc Degree" = "I",
                             "Bachelors Degree" = "J",
                             "Masters Degree" = "K",
                             "Doctorate" = "L"),
         MOTwork18 = ifelse(MOTworkhours18 >= 30, "A", MOTwork18),
         MOTwork18 = ifelse(subj %in% c("189","294"),"B",       # Three mothers not classed as working FT, PT or home, but fit within these categories
                          ifelse(subj =="288","C",  # mother works freelance part time - change to PT
                                 MOTwork18)),          # mother is disabled and is at home caring for infant - change to Home
         MOTwork18 = factor(MOTwork18),                           # mother is at home part-time studying - change to PT
         MOTwork18 = fct_recode(MOTwork18,
                              "Full-time" = "A",
                              "Part-time" = "B",
                              "Home" = "C"),
         MOTworkhours18 = ifelse(subj == "294", NA, MOTworkhours18),
         MOTwork6 = ifelse(MOTworkhours6 >= 30, "A", MOTwork6),
         MOTwork6 = ifelse(subj =="189","B",                 #  mother is at home part-time studying - change to PT
                                   MOTwork6),          
         MOTwork6 = factor(MOTwork6),                          
         MOTwork6 = fct_recode(MOTwork6,
                                "Full-time" = "A",
                                "Part-time" = "B",
                                "Home" = "C"),
         FATwork6 = ifelse(FATwork6 !="A" & FATwork6 !="B" & FATwork6 != "C", "C",  # Recode fathers' work status so that fathers who don't work FT, PT,
                          FATwork6),                                                      # or stay home (e.g. full-time students) are listed as 'other'
         FATwork6 = factor(FATwork6),
         FATwork6 = fct_recode(FATwork6,
                              "Full-time" = "A",
                              "Part-time" = "B",
                              "Home" = "C"),
         FATwork18 = ifelse(FATwork18 !="A" & FATwork18 !="B" & FATwork18 != "C", "C",  # Recode fathers' work status so that fathers who don't work FT, PT,
                            FATwork18),                                                      # or stay home (e.g. full-time students) are listed as 'other'
         FATwork18 = factor(FATwork18),
         FATwork18 = fct_recode(FATwork18,
                               "Full-time" = "A",
                               "Part-time" = "B",
                               "Home" = "C"),
         MOTedulevel = fct_recode(MOTedu,
                                  "1" = "High School",
                                  "2" = "Some college",
                                  "3" = "Assoc Degree",
                                  "4" = "Bachelors Degree",
                                  "5" = "Masters Degree",
                                  "6" = "Doctorate"),
         MOTedulevel = as.numeric(as.character(MOTedulevel)),
         HouseholdIncome6 = fct_recode(HouseholdIncome6,
                                       "6000" = "A",
                                       "11999" = "B",
                                       "16999" = "C",
                                       "22999" = "D",
                                       "28999" = "E",
                                       "39999" = "F",
                                       "54999" = "G",
                                       "74999" = "H",
                                       "99999" = "I",
                                       "124999" = "J",
                                       "125000" = "K"),
         HouseholdIncome6 = as.numeric(as.character(HouseholdIncome6)),
         HouseholdIncome18 = fct_recode(HouseholdIncome18,
                                        "6000" = "A",
                                        "11999" = "B",
                                        "16999" = "C",
                                        "22999" = "D",
                                        "28999" = "E",
                                        "39999" = "F",
                                        "54999" = "G",
                                        "74999" = "H",
                                        "99999" = "I",
                                        "124999" = "J",
                                        "125000" = "K"),
         HouseholdIncome18 = as.numeric(as.character(HouseholdIncome18)),
         siblings = children_in_household_18mos_staff - 1,
         family_size = adults_in_household_18mos + children_in_household_18mos_staff) %>%
  left_join(data, by = "subj") %>%  # merge with CDI data
  left_join(PVT, by = "subj") %>% # merge with PVT data
  dplyr::select(-adults_in_household_18mos, -children_in_household_18mos_staff, -month)
