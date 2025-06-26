Experiment 3 (Event Segmentation) readme

This folder contains the processed data and scripts needed to generate figures 3 and 4 and E3 results. Generated figures are saved in `figures/`. Fit Bayesian models are saved and read from `models/`. (There is no need to refit the models - `brm` will automatically load from these files.)

Note: Data and scripts for the pitch and rhythm control analysis has its own readme (`pitch_rhythm_control_analysis/`).


Data:

Data has been combined across dataset 3A (72 participants: 36 musicians and 36 non-musicians) and dataset 3B (23 participants: 13 musicians, 10 non-musicians). All data is from the second time the participant heard each stimulus. If a participant didn't respond in any condition in run 2, then they were excluded from the precision-sensitivity analysis, but not the rate analysis (5 participants: 4 musicians, 1 non-musician). (Participants who heard set 2 are excluded from this analysis, since set 1 and set 2 are highly overlapping and we didn't want to overrepresent certain stimuli in our results.)

`response_rate_by_sub.csv` has average response rate data. Each subject heard all four conditions; each subject has four rows in this file. Each row has subject ID (exp_subject_id), musical expertise (Musician: "Yes"/"No"), which stimulus set the subject heard (stimulus_set: 1/3/4), condition (scramble: 1B/2B/8B/Intact), and the response rate (mean_response_rate: number of responses per minute). Each subject heard two independent stimuli for each condition, so each rate represents an average rate over two stimuli. Rates greater than 30 responses per minute were excluded.

`timestamps_filtered_long.csv` has the raw annotation data transformed into a "long" form of timestamps. Columns are similar to `response_rate_by_sub.csv`, with the addition of which stimulus (stim_num: 1,3 for set 1, 1-16 for sets 3 and 4), and the timestamp value in seconds (value) instead of rate. Because the number of responses varies across runs, each subject has a different number of rows. Note on stimulus labeling in the data file: For set 1, each condition has stimulus number 1 and 3. For sets 3 and 4, stimuli 1-4 are Intact, stimuli 5-8 are 8B, stimuli 9-12 are 2B, and stimuli 13-16 are 1B. 

`ground_truths.csv` contains the ground truths event boundaries at different levels, used in `E3_compute_precision_sensitivity.ipynb`.

`alignment_original.csv` contains alignment values. The output of `E3_compute_precision_sensitivity.ipynb` will be called `alignment.csv`. Note that because samples are randomly generated for the null distribution, there may be some variability in exact alignment values. Thus we include the "original" alignment values since they are what we report in the paper.


Notebooks and scripts:

`E3_rate.Rmd` takes `response_rate_by_sub.csv`. It runs Bayesian linear mixed-effects model (LMEM) and generates figure 3.

`E3_compute_precision_sensitivity.ipynb` takes `timestamps_filtered_long.csv.` It computes precision, sensitivity, and overall alignment and saves alignment values in `alignment.csv`. Also generates figure 4.

If you want to skip the alignment computation and just generate figure 4, `E3_figure4.py` is a simple python script that does that using `alignment_original.csv`. Note that I am using Numpy 1.26.4 - I haven't tested this with Numpy 2.0.

`E3_alignment.Rmd` takes `alignment.csv` and runs Bayesian LMEMs (Table S5).

Each of the notebooks is knit to a PDF version if you want to see the code but not run it. Those files are `E3_rate.pdf`, `E3_compute_precision_sensitivity.pdf`, and `E3_alignment.pdf`.