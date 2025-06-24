Experiments 1 (Memory), 2 (Prediction), 4 (Categorization) readme

This folder contains the processed data and scripts needed to generate figures 2, 5, 6, and S1 and E1, E2, and E4 results.

`sub_ids.xlsx` contains the Labvanced IDs for the participants who completed the memory, prediction, and categorization tasks, as well as whether they were a musician or non-musician.

`years_musical_exp.xlsx` contains the years of musical experience reported by the musicians. Some participants included in the main analysis are not represented here because they did not report their years of experience in the post-survey.


Data:

`memory.csv`, `prediction.csv`, and `categorization.csv` have the processed data for each task. Each file contains each trial for each subject (including the trial number), which scramble condition (1B, 2B, 8B for all tasks, plus Intact for categorization), and whether or not they were correct. There are also columns for which group the subject was in (Musician: Yes or No) and their years of musical experience (if we have that information).

`dataConfuseMatrix.xlsx` has a representation of categorization results for each subject in each condition, that is then hard-coded in `confusion_matrix.R`. Musicians and non-musicians have separate sheets, but all data is on `Sheet1` and missing data can be seen on `Sheet1`. The `Expected` column has the right answer and the `Reference` column is the subject response.


Scripts:

`analysis.R` takes `data.xlsx` and generates figures 2A (memory), 2B (prediction), 5 (categorization), S1, and ANOVA results.

`confusion_matrix.R` generates figure 6 (confusion matrices).
