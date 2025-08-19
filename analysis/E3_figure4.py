# This script generates figure 4 (with legends for both panels). For computation of the alignment values see `E3_compute_precision_sensitivity.ipynb`

import numpy as np # version 1.26.4
import pandas as pd # version 2.1.4
import matplotlib.pyplot as plt # version 3.8.0
plt.rcParams["font.family"] = "Arial"
plt.rcParams["font.size"] = 12

# load the data
data = pd.read_csv('../data/E3/alignment_original.csv')
#data = pd.read_csv('../data/E3/alignment.csv')

# make the subject label categorical
data['sub'] = data['sub'].astype('category')

data_M = data[data['Musician'] == 'Yes']
data_NM = data[data['Musician'] == 'No']

# set condition info
conditions = ['Intact', '8B', '2B', '1B']
cond_colors = ['red', 'orange',  'green', 'blue']
cond_jitter = [-.225, -.075, .075, .225]
levels = np.asarray([1,2,3,4,5,8,16])
levels = np.flip(levels)

fig, ax = plt.subplots(1, 2, sharey = True, figsize = (18,6))

# this looks slightly different from `E3_compute_precision_sensitivity.ipynb` because how the data are saved/structured.
for c in range(len(conditions)):
	this_data = data_M[data_M['scramble'] == conditions[c]]
	these_means = this_data.mean(numeric_only = True)
	these_sems = this_data.sem(numeric_only = True)
	ax[0].plot(levels + cond_jitter[c], these_means, color = cond_colors[c], alpha = 1, label = conditions[c])
	ax[0].scatter(levels + cond_jitter[c], these_means, color = cond_colors[c], alpha = 1)
	ax[0].errorbar(levels + cond_jitter[c], these_means, yerr = these_sems, color = cond_colors[c], capsize = 3, alpha = 0.4)
	
	this_data = data_NM[data_NM['scramble'] == conditions[c]]
	these_means = this_data.mean(numeric_only = True)
	these_sems = this_data.sem(numeric_only = True)
	ax[1].plot(levels + cond_jitter[c], these_means, color = cond_colors[c], alpha = 1, label = conditions[c])
	ax[1].scatter(levels + cond_jitter[c], these_means, color = cond_colors[c], alpha = 1)
	ax[1].errorbar(levels + cond_jitter[c], these_means, yerr = these_sems, color = cond_colors[c], capsize = 3, alpha = 0.4)


ax[0].set_ylabel('Overall Alignment', fontsize = 22)
ax[0].set_title('Musicians', fontsize = 20)
ax[1].set_title('Non-musicians', fontsize = 20)

for col in range(2):
    ax[col].set_xlim(0, 17)
    ax[col].hlines(0,17,0, color = 'black', alpha = 0.2)
    ax[col].set_xticks(levels)
    ax[col].set_xticklabels(levels, fontsize = 16)
    ax[col].tick_params(axis='y', which='major', labelsize=14)
    ax[col].set_xlabel('Level (Bars)', fontsize = 18)
    ax[col].legend(fontsize=16)

#plt.show()
plt.savefig('../figures/Fig4_alignment.png', dpi=500)
