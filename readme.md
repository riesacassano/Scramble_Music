Welcome! This readme provides an overview of the data and materials in this repo. These materials (plus all musical stimuli) are also on OSF here: https://osf.io/mej7a/



# Data

All participants, except those in dataset 3B, completed two tasks: either the memory or prediction task, then either the segmentation or categorization task. Participants in dataset 3B only completed the event segmentation task.

When participants were recruited, they were assigned to a group, and we balanced the number of musicians and non-musicians in each group. Groups 1-3 completed the memory and event segmentation tasks, groups 4-6 completed the memory and categorization tasks, groups 7-9 completed the prediction and event segmentation tasks, and groups 10-12 completed the prediction and categorization tasks. Within a task (e.g. memory), all stimuli were taken from the same stimulus set, but the stimulus set used for the second task (e.g. categorization) was different from the set used for the first task. Each group heard a different combination of stimulus sets.

## Primary data

For experiments 1, 2, and 4, and dataset 3A, each participant has its own .csv file in `data/primary/individual_participants/` from Labvanced. Files are labeled with the participant's internal ID ('exp_subject_id' or 'Labvanced ID') which is consistent throughout. There were four additional subjects for dataset 3A for whom the raw data file was lost, but a minimally preprocessed version of the data is in `data/primary/subs_additional_E3A.xlsx`.

For dataset 3B, all raw data was obtained from Labvanced in one .csv file (`data/primary/raw_E3B.csv`).

Prolific IDs have been removed to ensure anonymity.

Descriptions of the variables are in `data/primary/primary_data_dictionary.xlsx`. Unfortunately, changes were made to the experiment during data collection, and those changes were not well-documented. Some variables are included in some participants raw data files and not others.


# Code

## System requirements

## 


# Models

`models` contains




# Output



'primary_data/' contains the raw data as we got it from Labvanced. We have removed Prolific IDs to ensure anonymity. Raw data is wrangled in various scripts and saved in `E1-E2-E4/` and `E3/`

'E1-E2-E4/' contains the data and analysis scripts needed to generate figures 2, 5, 6, and S1 and the results for experiments 1 (memory), 2 (prediction), and 4 (categorization). The analysis for these experiments was straightforward and similar enough that it made sense to group them into one folder.

'E3/' contains data and analysis scripts needed to generate figures 3 and 4 and the results for experiment 3 (event segmentation).