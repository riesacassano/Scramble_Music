Primary data readme

For experiments 1, 2, and 4, and dataset 3A, each participant has its own .csv file in 'raw_data_anonymized/' from Labvanced. Files are labeled with the participant's internal ID ('exp_subject_id' or 'Labvanced ID') which is consistent throughout. 

When participants were recruited, they were assigned to a group, and we balanced the number of musicians and non-musicians in each group. Groups 1-3 completed the memory and event segmentation tasks, groups 4-6 completed the memory and categorization tasks, groups 7-9 completed the prediction and event segmentation tasks, and groups 10-12 completed the prediction and categorization tasks. (Memory/prediction were always completed before segmentation or categorization.) Within a task (e.g. memory), all stimuli were taken from the same stimulus set, but the stimulus set used for the second task (e.g. categorization) was different from the set used for the first task. Each group heard a different combination of stimulus sets.

All raw data for E1, E2, and E4 is combined in `E124_raw_data_combining.py`, resulting in `E124_raw_combined.csv`. The data is prepared for analysis in `E124_raw_data_wrangling.R` and saved in `../E1-E2-E4/data/`.

For dataset 3B, all participants' data is recorded in 'raw_dataset_3B.csv'. (This was also obtained directly from Labvanced.) Participants' data from dataset 3A and 3B were combined and filtered to obtain the filtered data used for experiment 3 ('../Experiment 3-Event Segmentation/data/timestamps_filtered_long.csv' and '../Experiment 3-Event Segmentation/data/response_rate_by_sub.csv').

