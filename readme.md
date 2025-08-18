Welcome! The materials in this repo (plus all musical stimuli) are also on OSF here: https://osf.io/mej7a/

# Data

All participants, except those in dataset 3B, completed two tasks: either the memory or prediction task, then either the segmentation or categorization task. Participants in dataset 3B only completed the event segmentation task.

When participants were recruited, they were assigned to a group, and we balanced the number of musicians and non-musicians in each group. Groups 1-3 completed the memory and event segmentation tasks, groups 4-6 completed the memory and categorization tasks, groups 7-9 completed the prediction and event segmentation tasks, and groups 10-12 completed the prediction and categorization tasks. Within a task (e.g. memory), all stimuli were taken from the same stimulus set, but the stimulus set used for the second task (e.g. categorization) was different from the set used for the first task. Each group heard a different combination of stimulus sets.

## Primary data

For experiments 1, 2, and 4, and dataset 3A, each participant has its own .csv file in `data/primary/individual_participants/` from Labvanced. Files are labeled with the participant's internal ID ('exp_subject_id' or 'Labvanced ID') which is consistent throughout. There were four additional subjects for dataset 3A for whom the raw data file was lost, but a minimally preprocessed version of the data is in `data/primary/subs_additional_E3A.xlsx`.

For dataset 3B, all raw data was obtained from Labvanced in one .csv file (`data/primary/raw_E3B.csv`).

Prolific IDs have been removed to ensure anonymity.

Descriptions of the variables are in `data/primary/primary_data_dictionary.xlsx`. Unfortunately, changes were made to the experiment during data collection, and those changes were not well-documented. This means that some variables are included in some participants raw data files and not others.

**Note:** data for the confusion matrices was manually coded and saved in `data/primary/dataConfuseMatrix.xlsx`. While this is not technically primary data, it is the only data file used in analysis that is manually coded and not produced by one of the processing scripts described below.


## Processed data

The scripts described in the following steps are found in `analysis/data_processing/` and need to be run prior to running the analysis notebooks (described below).

Steps for experiments 1, 2, and 4:
1. `E124_raw_data_combining.py` combines the raw data for these three experiments from `data/primary/` and saves it in `data/E1-E2-E4/`
2. `E124_raw_data_wrangling.R` takes the combined version of the data and...

Steps for experiment 3:



# Analysis

## Requirements

**Python and associated packages**
- Python 3.11.8
- numpy 1.26.4
- pandas 2.2.3

**R and associated packages**
- R 4.3.3
- RStudio 2024.12.0+467
- tidyverse 2.0.0
- magrittr 2.0.3
- readxl 1.4.3

## Models

The `analysis/models` contains

## Analysis order

Data processing scripts (described above) need to be run prior to any of the analysis notebooks described below.

Each analysis notebook (`.Rmd` files) are meant to stand on their own, so they can be run in any order. However, (E3 exception)

## Experiment 1 (Memory)

Figure 2A

## Experiment 2 (Prediction)

Figure 2B

## Experiment 3 (Event segmentation)

Figures 3 and 4


## Experiment 4 (Categorization)

Figures 5 and 6

## Notebook PDFs

All `.Rmd` and `.ipynb` files are knit or downloaded as a PDF version, so viewers can see the analysis steps and output without having to run the code in the notebooks. These PDF versions are in `analysis/notebooks/`





# Output

(figures)
