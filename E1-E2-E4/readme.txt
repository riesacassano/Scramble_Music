Experiments 1 (Memory), 2 (Prediction), 4 (Categorization) readme

This folder contains the processed data and scripts needed to generate figures 2, 5, 6, and S1 and E1, E2, and E4 results.

`sub_ids.xlsx` contains the Labvanced IDs for the participants who completed the memory, prediction, and categorization tasks, as well as whether they were a Musician or Non-musician.

`years_musical_exp.xlsx` contains the years of musical experience reported by the musicians. Some participants included in the main analysis are not represented here because they did not report their years of experience in the post-survey.


Data:

`data.xlsx` has the processed data for prediction, memory, and categorization. For each task performed, accuracy was computed for each condition. 

`dataConfuseMatrix.xlsx` has a representation of categorization results for each subject in each condition, that is then hard-coded in `confusion_matrix.R`. Musicians and non-musicians have separate sheets, but all data is on `Sheet1` and missing data can be seen on `Sheet1`. The `Expected` column has the right answer and the `Reference` column is the subject response.

Scripts:

`analysis.R` takes `data.xlsx` and generates figures 2A (memory), 2B (prediction), 5 (categorization), S1, and ANOVA results.

`confusion_matrix.R` generates figure 6 (confusion matrices).
