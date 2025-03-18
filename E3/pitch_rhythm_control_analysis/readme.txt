Pitch and rhythm analysis readme

Data:

There is one file per condition that contains the information about all ten stimuli from that condition (2 from set 1, 4 each from set 3 and 4) labeled `pitch_rhythm_resp_(cond).csv`. (`resp` is short for responses.) Each beat (= 1 second) in the stimulus is a row. Each row contains average pitch height change from the previous beat (pitch_change), rhythmic density change from the previous beat (rhythm_change), whether or not the beat is the end of a phrase (boundaries), how many musicians responded (n_M_resp), and how many non-musicians responded (n_NM_resp). There is a one second window, such that responses during that beat and the second immediately after count for that beat. (This is analogous to the window size in the precision-sensitivity analysis.) 

We also noted boundaries, but they aren't used in the analysis reported here. For Intact and 8B, we marked the beat/second at the end of each 8-bar phrase. For 2B and 1B, we use "tracked" boundaries--for each phrase-ending beat from Intact, we found where it ended up after the scramble.

The `By_Stimulus` folder includes one subfolder for each condition. Each subfolder contains each stimulus as a separate CSV. All of this information is in the `pitch_rhythm_resp_(cond).csv` files.

Notebook:

`pitch_and_rhythm.Rmd` use linear models with absolute pitch change, absolute rhythm change, and their interaction to predict number of participants responding separately for each condition and group (musicians vs non-musicians). There's more that one could do with this data - this is bare bones!