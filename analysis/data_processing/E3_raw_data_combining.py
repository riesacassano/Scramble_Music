# This script combines the raw data files for dataset 3A (from 'data/primary/') and saves them in a large csv file in 'data/E3/'. It should be run from the 'analysis/' folder. Additional subjects and dataset 3B are included in the next step.

import os
import numpy as np
import pandas as pd

# load the file list
folder = '../data/primary/individual_participants/'
file_list = os.listdir(folder)
file_list.sort()

df_list = []
count = 0

for entry in file_list:
#for i in range(2):
#	entry = file_list[i]
	filepath = folder + entry

	if '.csv' in filepath: this_file = pd.read_csv(filepath)
	else: continue

	# select the columns of interest
	# exp_subject_id
	# Task_Name
	# Trial_Id
	# participant_spacePress2
	# condition is under something with scramble in it

	this_file1 = this_file[['exp_subject_id', 'Task_Name', 'Trial_Id', 'participant_spacePress2']]
	this_file2 = this_file.filter(like = 'scramble')
	this_file_selected = pd.concat([this_file1, this_file2], axis=1)

	df_list.append(this_file_selected)

# concatenate
big_df = pd.concat(df_list, ignore_index = True)
big_df.to_csv('../data/E3/raw_combined_3A.csv', index = False)