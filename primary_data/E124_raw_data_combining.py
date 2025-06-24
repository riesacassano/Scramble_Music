# This script combines the raw data files for E1, E2, and E4.

import os
import numpy as np
import pandas as pd

# load the file list
folder = '../data/Sarah_E124/raw_data/'
file_list = os.listdir(folder)

df_list = []

for entry in file_list:
#for i in range(2):
#	entry = file_list[i]
	filepath = folder + entry
	print(entry)
	if '.xlsx' in filepath: this_file = pd.read_excel(filepath)
	elif '.csv' in filepath: this_file = pd.read_csv(filepath)
	
	# check length anomalies
	#if len(this_file) != 65: 
	#	print(entry, len(this_file))
	
	# select the columns of interest
	# check header anomalies - manually fixed
	#if this_file.columns[1] != "Block_Name": print(entry, this_file.columns[1])

	# exp_subject_id
	# Task_Name
	# Trial_Nr
	# response (may be duplicated?)
	# condition is under 'scramble_p_3', 'scramble_m_2'... seems like all options are there as empty columns
	
	#this_file1 = this_file[['exp_subject_id', 'Task_Name', 'Trial_Nr', 'response', 'response_seg2']]
	if 'response_seg2' in this_file.columns:
		this_file1 = this_file[['exp_subject_id', 'Task_Name', 'Trial_Nr', 'response', 'response_seg2']]
	else: 
		this_file1 = this_file[['exp_subject_id', 'Task_Name', 'Trial_Nr', 'response']]
		this_file1['response_seg2'] = np.nan
	this_file2 = this_file.filter(like = 'scramble')

	this_file_selected = pd.concat([this_file1, this_file2], axis=1)
	df_list.append(this_file_selected)
	#print(this_file_selected)
	
	

# concatenate
big_df = pd.concat(df_list, ignore_index = True)
big_df.to_csv('../data/Sarah_E124/combined_raw.csv', index = False)