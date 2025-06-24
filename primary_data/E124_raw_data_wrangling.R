library(tidyverse) # version 2.0.0
library(magrittr) # version 2.0.3
library(readxl) # version 1.4.3
select <- dplyr::select # make sure we're using the dplyr version of the select function

# This script combines the raw data for E1, E2, and E4, retaining individual trial-level information.

# set working directory
setwd("/Users/rcassan2/Documents/GitHub/Scramble_Music/primary_data/")

# data files were combined and columns were selected using pandas
# load the combined file
data <- read_csv("raw_combined.csv")
# load the file with years of musical experience from the E1-E2-E4 folder
data_yrs <- read_excel("../E1-E2-E4/years_musical_exp.xlsx")
# load the subject list
subs <- read_excel('../E1-E2-E4/sub_ids.xlsx')

# extract the main task, remove practice task and instruction
memory <- data %>%
  filter(grepl('Memory', Task_Name)) %>%
  filter(!grepl('Practice', Task_Name)) %>%
  filter(!grepl('Instructions', Task_Name)) %>%
  mutate(scramble = ifelse(!is.na(scramble_m_1), scramble_m_1,
                           ifelse(!is.na(scramble_m_2), scramble_m_2, scramble_m_3))) %>%
  select(c(exp_subject_id, Trial_Nr, response, scramble)) 
  
prediction <- data %>%
  filter(grepl('Prediction', Task_Name)) %>%
  filter(!grepl('Practice', Task_Name)) %>%
  filter(!grepl('Instructions', Task_Name)) %>%
  mutate(scramble = ifelse(!is.na(scramble_p_1), scramble_p_1,
                           ifelse(!is.na(scramble_p_2), scramble_p_2, scramble_p_3))) %>%
  select(c(exp_subject_id, Trial_Nr, response, scramble)) 

categorization <- data %>%
  filter(grepl('Categorization', Task_Name)) %>%
  filter(!grepl('Practice', Task_Name)) %>%
  filter(!grepl('Instructions', Task_Name)) %>%
  mutate(scramble = ifelse(!is.na(scramble_cat_1), scramble_cat_1,
                           ifelse(!is.na(scramble_cat_3), scramble_cat_3, scramble_catseg_4))) %>%
  select(c(exp_subject_id, Trial_Nr, response_seg2, scramble)) %>%
  rename(response = response_seg2)


# get the task-specific the subject lists
memory_subs <- select(subs, c("Memory sub ids", "Musician?...2" )) %>%
  rename("Musician" = "Musician?...2")
prediction_subs <- select(subs, c("Prediction sub ids", "Musician?...5" ))%>%
  rename("Musician" = "Musician?...5") %>%
  na.omit()
categorization_subs <- select(subs, c("Categorization sub ids", "Musician?...8" )) %>%
  rename("Musician" = "Musician?...8")


# join Musician information and years of musical experience, if available
memory %<>% 
  left_join(., memory_subs, by = join_by('exp_subject_id' == 'Memory sub ids'), "many-to-one") %>%
  left_join(., data_yrs, by = join_by('exp_subject_id' == 'LabvancedID')) %>%
  mutate(Musician = as.factor(Musician))
prediction %<>% 
  left_join(., prediction_subs, by = join_by('exp_subject_id' == 'Prediction sub ids'), "many-to-one") %>%
  left_join(., data_yrs, by = join_by('exp_subject_id' == 'LabvancedID')) %>%
  mutate(Musician = as.factor(Musician))
categorization %<>% 
  left_join(., categorization_subs, by = join_by('exp_subject_id' == 'Categorization sub ids'), "many-to-one") %>%
  left_join(., data_yrs, by = join_by('exp_subject_id' == 'LabvancedID')) %>%
  mutate(Musician = as.factor(Musician))


# there are more subjects than who we include
print(length(unique(memory$exp_subject_id))) # 129
print(length(unique(prediction$exp_subject_id))) # 123
print(length(unique(categorization$exp_subject_id))) # 122

memory %<>% filter(!is.na(Musician))
prediction %<>% filter(!is.na(Musician))
categorization %<>% filter(!is.na(Musician))

# check again
print(length(unique(memory$exp_subject_id))) # 102 
print(length(unique(prediction$exp_subject_id))) # 105
print(length(unique(categorization$exp_subject_id))) # 106

# are the groups balanced?
print(length(unique(filter(memory, Musician == 'Yes')$exp_subject_id))) # 52 / 102 are musicians
print(length(unique(filter(prediction, Musician == 'Yes')$exp_subject_id))) # 53 / 105 are musicians
print(length(unique(filter(categorization, Musician == 'Yes')$exp_subject_id))) # 54 / 106 are musicians

# save the wrangled data
write_csv(memory, '../E1-E2-E4/data/memory.csv')
write_csv(prediction, '../E1-E2-E4/data/prediction.csv')
write_csv(categorization, '../E1-E2-E4/data/categorization.csv')


