library(tidyverse) # version 2.0.0
library(magrittr) # version 2.0.3
library(readxl) # version 1.4.3
library(mvnormtest) # version 0.1-9-3
library(ggpubr) # version 0.6.0
library(rstatix) # version 0.7.2
library(plotrix) # version 3.8-4
library(car) # version 3.1-2
library(effectsize) # version 0.8.9

# set your working directory here!
#setwd()

# import data
mydata <- read_excel("../data/data.xlsx")
mydata$Musician <- ifelse(mydata$Musician == "Yes", "Musicians", "Non-musicians")
memory <-mydata[mydata$task == '0',]
prediction <-mydata[mydata$task == '1',]

# bar graphs
# gather columns for accuracy into long format
# convert ID and musician to factor variable
memory <- memory %>%
  gather(key = "scramble", value = "accuracy", memAcc8b, memAcc2b, memAcc1b) %>%
  convert_as_factor(LabvancedID, scramble)

prediction <- prediction %>%
  gather(key = "scramble", value = "accuracy", predAcc8b, predAcc2b, predAcc1b) %>%
  convert_as_factor(LabvancedID, scramble)

segmentation <- mydata %>%
  gather(key = "scramble_seg", value = "accuracy", seg_intact, seg_8b, seg_2b, seg_1b) %>%
  convert_as_factor(LabvancedID, scramble_seg)

segmentation_1 <- select(segmentation, scramble_seg, Musician, accuracy)
segmentation_noNA <- na.omit(segmentation_1)

# plot accuracy on memory task with standard error (Figure 2A, with legend)
memory %>%
  group_by(scramble, Musician) %>%
  summarise(mean_accuracy = mean(accuracy, na.rm = TRUE),
            sem = std.error(accuracy, na.rm = TRUE)) %>%
  ggplot(aes(x = scramble, y = mean_accuracy, fill = Musician, group = Musician)) +
  geom_col(position = "dodge", width = 0.9)+
  geom_errorbar(aes(ymin=mean_accuracy-sem, ymax=mean_accuracy+sem), 
                position = position_dodge(width = 0.9),  
                width=0.4, alpha=0.9, linewidth=.5) +
  geom_hline(yintercept = 0.5, linetype = "dotted", color = "black", linewidth = 1) +
  scale_x_discrete(labels = c('1B', '2B', '8B')) +
  theme_gray(base_size = 16) +
  theme(legend.title = element_blank()) +
  xlab("Scramble Level") +
  ylab("Proportion Correct (Memory)") +
  ylim(0, .85)
#ggsave('../figure_2A.png', width = 6, height = 5)

# plot accuracy on prediction task (Figure 2B, with legend)
prediction %>%
  group_by(scramble, Musician) %>%
  summarise(mean_accuracy = mean(accuracy, na.rm = TRUE),
            sem = std.error(accuracy, na.rm = TRUE)) %>%
  ggplot(aes(x = scramble, y = mean_accuracy, fill = Musician, group = Musician)) +
  geom_col(position = "dodge", width = 0.9)+
  geom_errorbar(aes(ymin=mean_accuracy-sem, ymax=mean_accuracy+sem), 
                position = position_dodge(width = 0.9),  
                width=0.4, alpha=0.9, linewidth=.5) +
  geom_hline(yintercept = 0.5, linetype = "dotted", color = "black", size = 1) +
  scale_x_discrete(labels = c('1B', '2B', '8B')) +
  theme_gray(base_size = 16) +
  theme(legend.title = element_blank()) +
  xlab("Scramble Level") +
  ylab("Proportion Correct (Prediction)") +
  ylim(0, .85)
#ggsave('../figure_2B.png', width = 6, height = 5)

# plot accuracy on categorization second run (Figure 5)
segmentation_noNA %>%
  group_by(scramble_seg, Musician) %>%
  summarise(mean_accuracy = mean(accuracy, na.rm = TRUE),
            sd = std.error(accuracy, na.rm = TRUE)) %>%
  ggplot(aes(x = scramble_seg, y = mean_accuracy, fill=Musician, group = Musician))+
  geom_col(position="dodge")+
  geom_errorbar( aes(ymin=mean_accuracy-sd, ymax=mean_accuracy+sd), position = position_dodge(width=0.9), width=0.4, alpha=0.9, size=.5) +
  geom_hline(yintercept = 0.25, linetype = "dotted", color = "black", size = 1) +  # Increase the size parameter
  theme_gray(base_size = 16) +
  theme(legend.title = element_blank(), legend.text = element_text(size = 12)) +
  xlab("Scramble Level") +
  ylab("Proportion Correct") +
  scale_x_discrete(labels = c("1B", "2B", "8B", "Intact")) +
  ylim(0, 0.85)
#ggsave('../figure_5.png', width = 7, height = 5)



# we use type II and III ANOVA from the car package because they test simultaneously (unlike Type I, which is sequential)
# for more info: https://md.psych.bio.uni-goettingen.de/mv/unit/lm_cat/lm_cat_unbal_ss_explained.html

# memory:
# is the interaction significant?
lm.memory_noint <- lm(accuracy ~ Musician+scramble, data = memory)
lm.memory_int <- lm(accuracy ~ Musician*scramble, data = memory)
anova(lm.memory_noint, lm.memory_int)
# because the model with the interaction is not significantly more explanatory than the model without, we'll proceed with type II ANOVA
  
# run the ANOVA
Anova(lm.memory_noint, type="2")

# calculate effect size
eta_squared(Anova(lm.memory_noint, type="2")) # default: partial = TRUE

# to get three sig figs, as reported in the paper I calculated Sum Sq (effect) / Sum Sq (total)
# for example: partial eta^2 for Musician was 0.1446 / (0.1446 + 1.8754 + 7.8516) = 0.01465 or ~ 0.015



# prediction:
# is the interaction significant?
lm.prediction_noint <- lm(accuracy ~ Musician+scramble, data = prediction)
lm.prediction_int <- lm(accuracy ~ Musician*scramble, data = prediction)
anova(lm.prediction_noint, lm.prediction_int)
# because the model with the interaction is marginally significantly more explanatory than the model without, we'll proceed with type III ANOVA

# run the ANOVA
lm.prediction <- lm(accuracy ~ Musician*scramble, data = prediction,
                    contrasts=list(Musician=contr.sum, scramble=contr.sum))
Anova(lm.prediction, type="3")

# calculate effect size
eta_squared(Anova(lm.prediction, type="3"))

# post-hoc test: are participants above chance in 1B? (sanity check)
t.test(filter(prediction, scramble == "predAcc1b")$accuracy, mu = 0.5)
# nope!



# categorization:
# is the interaction significant?
lm.categ_noint <- lm(accuracy ~ Musician+scramble_seg, data = segmentation_noNA)
lm.categ_int <- lm(accuracy ~ Musician*scramble_seg, data = segmentation_noNA)
anova(lm.categ_noint, lm.categ_int)
# because the model with the interaction is not significantly more explanatory than the model without, we'll proceed with type II ANOVA

Anova(lm.categ_int, type="3")

# run the ANOVA
Anova(lm.categ_noint, type="2")

# calculate effect size
eta_squared(Anova(lm.categ_noint, type="2"))



# figure S1: accuracy as a function of musical expertise

yrs_info <- mydata %>%
  #select(`LabvancedID`, `years musical exp`) %>%
  filter(!is.na(`years musical exp`)) %>%
  rename(yrs_exp = `years musical exp`)

# manually fix some of the values
yrs_info$yrs_exp[yrs_info$yrs_exp == '15?'] = 15
yrs_info$yrs_exp[yrs_info$yrs_exp == '4? 5?'] = 5
yrs_info$yrs_exp[yrs_info$yrs_exp == '9+'] = 9  

# this is purely exploratory - may want multiple comparisons corrections
# only overall prediction accuracy is reported in the paper

yrs_info$yrs_exp <- as.numeric(yrs_info$yrs_exp)

summary(lm(`overallMemAcc` ~ yrs_exp, yrs_info)) #NS
summary(lm(`memAcc8b` ~ yrs_exp, yrs_info)) # beta = -.0117, p = .0119
summary(lm(`memAcc2b` ~ yrs_exp, yrs_info)) #NS
summary(lm(`memAcc1b` ~ yrs_exp, yrs_info)) #NS

summary(lm(`overal pred acc` ~ yrs_exp, yrs_info)) #NS
summary(lm(`predAcc8b` ~ yrs_exp, yrs_info)) #NS
summary(lm(`predAcc2b` ~ yrs_exp, yrs_info)) #NS
summary(lm(`predAcc1b` ~ yrs_exp, yrs_info)) #NS

summary(lm(seg2 ~ yrs_exp, yrs_info)) #NS
summary(lm(seg_intact ~ yrs_exp, yrs_info)) #NS
summary(lm(seg_8b ~ yrs_exp, yrs_info)) # beta = -.0268, p = .0478
summary(lm(seg_2b ~ yrs_exp, yrs_info)) #NS
summary(lm(seg_1b ~ yrs_exp, yrs_info)) #NS


# plot overall accuracies
ggplot(yrs_info, aes(yrs_exp, overallMemAcc)) +
  geom_point() +
  geom_smooth(method = 'lm', color = '#F8766D', fill = '#F8766D') +
  xlab('Years of Musical Experience') +
  ylab('Overall Proportion Correct (Memory)') +
  scale_x_continuous(breaks = seq(5,30,5)) +
  scale_y_continuous(breaks = seq(0.4, 1, 0.1)) +
  ylim(0.4, 1) +
  theme_gray(base_size = 16)
#ggsave('../figure_S1A.png', width = 5, height = 5)

ggplot(yrs_info, aes(yrs_exp, `overal pred acc`)) +
  geom_point() +
  geom_smooth(method = 'lm', color = '#F8766D', fill = '#F8766D') +
  xlab('Years of Musical Experience') +
  ylab('Overall Proportion Correct (Prediction)') +
  scale_x_continuous(breaks = seq(5,30,5)) +
  scale_y_continuous(breaks = seq(0.4, 1, 0.1)) +
  ylim(0.4, 1) +
  theme_gray(base_size = 16)
#ggsave('../figure_S1B.png', width = 5, height = 5)

ggplot(yrs_info, aes(yrs_exp, seg2)) +
  geom_point() +
  geom_smooth(method = 'lm', color = '#F8766D', fill = '#F8766D') +
  xlab('Years of Musical Experience') +
  ylab('Overall Proportion Correct (Segmentation)') +
  scale_x_continuous(breaks = seq(5,30,5)) +
  scale_y_continuous(breaks = seq(0.4, 1, 0.1)) +
  ylim(0.4, 1) +
  theme_gray(base_size = 16)
#ggsave('../figure_S1C.png', width = 5, height = 5)
