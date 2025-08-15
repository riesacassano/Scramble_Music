# This script combines the raw data files for E3, dataset A

import os
import numpy as np
import pandas as pd

# load the file list
folder = 'raw_data_anonymized/'
file_list = os.listdir(folder)

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
big_df.to_csv('raw_combined_E3A.csv', index = False)