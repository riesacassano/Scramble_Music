Experiments 1 (Memory), 2 (Prediction), 4 (Categorization) readme

This folder contains the processed data and scripts needed to generate figures 2, 5, 6, and S1 and E1, E2, and E4 results.

Data:

`data.xlsx` has the processed data for prediction, memory, and categorization. For each task performed, accuracy was computed for each condition. 

`dataConfuseMatrix.xlsx` has a representation of categorization results for each subject in each condition, that is then hard-coded in `confusion_matrix.R`. Musicians and non-musicians have separate sheets, but all data is on `Sheet1` and missing data can be seen on `Sheet1`. The `Expected` column has the right answer and the `Reference` column is the subject response.

Scripts:

`analysis.R` takes `data.xlsx` and generates figures 2A (memory), 2B (prediction), 5 (categorization), S1, and ANOVA results.

`confusion_matrix.R` generates figure 6 (confusion matrices).
