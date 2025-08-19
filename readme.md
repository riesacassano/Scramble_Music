Welcome! The materials in this repo (plus all musical stimuli) are also on OSF here: https://osf.io/mej7a/

# Data

All participants, except those in dataset 3B, completed two tasks: either the memory or prediction task, then either the segmentation or categorization task. Participants in dataset 3B only completed the event segmentation task.

When participants were recruited, they were assigned to a group, and we balanced the number of musicians and non-musicians in each group. Groups 1-3 completed the memory and event segmentation tasks, groups 4-6 completed the memory and categorization tasks, groups 7-9 completed the prediction and event segmentation tasks, and groups 10-12 completed the prediction and categorization tasks. Within a task (e.g. memory), all stimuli were taken from the same stimulus set, but the stimulus set used for the second task (e.g. categorization) was different from the set used for the first task. Each group heard a different combination of stimulus sets.

## Primary data

For experiments 1, 2, and 4, and dataset 3A, each participant has its own .csv file in `data/primary/individual_participants/` from Labvanced. Files are labeled with the participant's internal ID ('exp_subject_id' or 'Labvanced ID') which is consistent throughout. There were four additional subjects for dataset 3A for whom the raw data file was lost, but a minimally preprocessed version of the data is in `data/primary/subs_additional_E3A.xlsx`.

For dataset 3B, all raw data was obtained from Labvanced in one .csv file (`data/primary/raw_E3B.csv`).

Prolific IDs have been removed to ensure anonymity.

Descriptions of the variables are in `data/data_dictionaries/primary_data_dictionary.xlsx`. Unfortunately, changes were made to the experiment during data collection, and those changes were not well-documented. This means that some variables are included in some participants raw data files and not others.

**Note:** data for the confusion matrices was manually coded and saved in `data/primary/dataConfuseMatrix.xlsx`. While this is not technically primary data, it is the only data file used in analysis that is manually coded and not produced by one of the processing scripts described below. Musicians and non-musicians have separate sheets, but all data is on `Sheet1` and missing data can be seen on `Sheet1`. The `Expected` column has the right answer and the `Reference` column is the subject response.


## Processed data

All data in these folders (`data/E1-E2-E4/` and `data/E3/`) are produced by the data processing steps described here *except* `data/E3/alignment_original.csv` (see note below).

The scripts described in the following steps are found in `analysis/data_processing/` and need to be run prior to running the analysis notebooks (described below). Columns are described in respective data dictionaries in `data/data_dictionaries/`.

Steps for experiments 1, 2, and 4:
1. `E124_raw_data_combining.py` combines the raw data for these three experiments from `data/primary/` and saves it in `data/E1-E2-E4/`
2. `E124_raw_data_wrangling.R` takes the combined version of the data, cleans it up, and saves it in separate files for each task (in the `data/E1-E2-E4/` folder: `memory.csv`, `prediction.csv`, `categorization.csv`).

Steps for experiment 3:
1. `E3_raw_data_combining.py` combines the raw data for experiment 3, dataset A from `data/primary/` and saves it in `data/E3/`
2. `E3_raw_data_wrangling.Rmd` takes the combined version of dataset 3A, adds the additional subjects from `subs_additional_E3A.xlsx`, and computes response rate and extracts timestamps. It then computes rate and extracts timestamps from dataset 3B, standardizes column names, and combines across datasets. Processed data is saved in `data/E3/`.

(For E3, participants who heard set 2 are excluded from this analysis, since set 1 and set 2 are highly overlapping and we didn't want to overrepresent certain stimuli in our results.)


## Other folders

### Data dictionaries

`data/data_dictionaries` contains the descriptions of data as promised elsewhere.

### Subject info

`data/subject_info` contains lists of subjects with complete datasets for each experiment and whether they were a musician or not (`data/subject_info/E*_sub_ids.xlsx`) as well as their years of musical experience, if applicable (`data/subject_info/E*_years_musical_exp.xlsx`, extracted from post-survey responses). 


### Stimulus info

`data/stimulus_info_E3` contains additional information about the stimuli that is necessary for running the E3 analyses. This included ground truth about event boundaries for the alignment analysis (`ground_truths.csv`) as well as pitch and rhythm information extracted from the MIDI files.

**Pitch and rhythm control analysis:** There is one file per condition that contains the information about all ten stimuli from that condition (2 from set 1, 4 each from set 3 and 4) labeled `pitch_rhythm_resp_(cond).csv`. (`resp` is short for responses.) Each beat (= 1 second) in the stimulus is a row. Each row contains average pitch height change from the previous beat (pitch_change), rhythmic density change from the previous beat (rhythm_change), whether or not the beat is the end of a phrase (boundaries), how many musicians responded (n_M_resp), and how many non-musicians responded (n_NM_resp). There is a one second window, such that responses during that beat and the second immediately after count for that beat. (This is analogous to the window size in the precision-sensitivity analysis.) 

We also noted boundaries, but they aren't used in the analysis reported here. For Intact and 8B, we marked the beat/second at the end of each 8-bar phrase. For 2B and 1B, we use "tracked" boundaries--for each phrase-ending beat from Intact, we found where it ended up after the scramble.

The `by_stimulus` folder includes one subfolder for each condition. Each subfolder contains each stimulus as a separate csv. All of this information is in the `pitch_rhythm_resp_(cond).csv` files.



# Analysis

## Requirements

**Python and associated packages**
- Python 3.11.8
- numpy 1.26.4
- pandas 2.2.3
- scipy 1.14.1
- matplotlib 3.10.0
- Jupyter notebook 7.0.8

**R and associated packages**
- R 4.3.3
- RStudio 2024.12.0+467
- tidyverse 2.0.0
- magrittr 2.0.3
- readxl 1.4.3
- brms 2.22.0
- bayestestR 0.15.0
- emmeans 1.10.0
- rstatix 0.7.2
- caret 6.0-94
- reshape2 1.4.4

## Models

The `analysis/models/` contains all of the fit Bayesian models used in the analysis. brms will automatically load these models if it can find them.

## Analysis order

Data processing scripts (described above, stored in `analysis/data_processing/`) need to be run prior to any of the analysis notebooks described below.

Each analysis notebook (`.Rmd` files) are meant to stand on their own, so they can be run in any order. However, (E3 exception)


## Notebook PDFs

All `.Rmd` and `.ipynb` files are knit or downloaded as a PDF version, so viewers can see the analysis steps and output without having to run the code in the notebooks. These PDF versions are in `analysis/notebooks/`.




# Figures

## Experiments 1 (Memory), 2 (Prediction), and 4 (Categorization)

`analysis/E1_memory.Rmd` generates figures 2A and S1A. `analysis/E2_memory.Rmd` generates figures 2B and S1B. `analysis/E4_categorization.Rmd` generates figures 5 and S1C. `analysis/E4_confusion_matrix.R` generates figure 6. Multi-panel figures are combined manually in `figures/combined figures.pptx` and saved in `figures/`.

## Experiment 3 (Event segmentation)
