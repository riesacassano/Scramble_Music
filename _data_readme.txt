Primary data readme

For experiments 1, 2, and 4, and dataset 3A, each participant has its own .csv file in 'raw_data_anonymized/' from Labvanced. Files are labeled with the participant's internal ID ('exp_subject_id' or 'Labvanced ID') which is consistent throughout. There were four additional subjects for dataset 3A for whom the raw data file was lost, but a minimally preprocessed version of the data is in 'subs_additional_E3A.xlsx'

When participants were recruited, they were assigned to a group, and we balanced the number of musicians and non-musicians in each group. Groups 1-3 completed the memory and event segmentation tasks, groups 4-6 completed the memory and categorization tasks, groups 7-9 completed the prediction and event segmentation tasks, and groups 10-12 completed the prediction and categorization tasks. (Memory/prediction were always completed before segmentation or categorization.) Within a task (e.g. memory), all stimuli were taken from the same stimulus set, but the stimulus set used for the second task (e.g. categorization) was different from the set used for the first task. Each group heard a different combination of stimulus sets.

All raw data for E1, E2, and E4 is combined in `E124_raw_data_combining.py`, resulting in `raw_combined_E124.csv`. The data is prepared for analysis in `E124_raw_data_wrangling.R` and saved in `../E1-E2-E4/data/`.

All raw data for E3 dataset A is combined in `E3_raw_data_combining.py`, resulting in `raw_combined_E3A.csv`. All raw data for E3 dataset B is in 'raw_combined_E3B.csv'. (This was obtained directly from Labvanced.) The data is prepared for analysis in `E3_raw_data_wrangling.Rmd` and saved in `../E3/data/`.

