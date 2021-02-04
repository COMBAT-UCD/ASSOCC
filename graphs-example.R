#Made by Barnard Kroon (University College Dublin) for COMBAT
#Based on original script by Maarten Jensen (Umea University) & Kurt Kreulen (TU Delft) for ASSOCC

rm(list=ls())

# #then install packages (NOTE: this only needs to be done once for new users of RStudio!)
#install.packages("ggplot2")
#install.packages("plotly")
#install.packages("tidyr")

#then load relevant libraries
library(ggplot2)
library(plotly)
library(tidyr)

workdirec <- "E:/Repositories/Combat/ASSOCC/"
setwd(workdirec)

filesPath <- "E:/Repositories/Combat/ASSOCC/results/"
filesNames <- c("S6.csv")

outputFile <- "Example - Scenario 6 - Combined plots.pdf"

source("main_behaviorspace_table_output_handling.R")

clean_df <- processData(workdirec, filesPath, filesNames)

# Prepare data for plotting

# SPECIFY VARIABLE MEASUREMENT SCALES -----------------------------------------------------
### MANUAL INPUT: in order for ggplot and plotly to work, one must specify the following: ###
#-> continuous decimal (floating) variables as 'numeric'
#-> continuous integer variables as 'integer'
#-> discrete (or categorical) variables as 'factor'

#print an overview of variables and their measurement scales
#str(df_long)
#transform 'measurement' variable to numeric (as to avoid ggplot errors)
#df_long$measurement <- as.numeric(df_long$measurement)
#round 'measurement' variable to 4 decimals
#df_long$measurement <- round(df_long$measurement, 4)
#convert categorical variables to factors (as to avoid ggplot errors)
#df_long$X.run.number. <- as.factor(df_long$X.run.number.)
#df_long$ratio.of.people.using.the.tracking.app <- as.factor(df_long$ratio.of.people.using.the.tracking.app)
#df_long$variable <- as.factor(df_long$variable)
#perform some small checks to see whether everything is OK
#str(df_long)

# PLOTTING -----------------------------------------------------
# `newcol` is the new column name
# `year`, and `cistomerID` are the columns combined to generate `newcol`
# unite(df, newcol, c(year, customerID), remove=FALSE)

clean_df$ratio.of.people.using.the.tracking.app <- as.factor(clean_df$ratio.of.people.using.the.tracking.app)

# Plot data

export_pdf = TRUE;
if (export_pdf) {
  pdf(file=outputFile, width=9, height=6);
  par(mfcol=c(2,3))
}

#infected plot with trendline
ggplot(clean_df, aes(x=X.step., y=X.infected, fill=ratio.of.people.using.the.tracking.app)) +
  # geom_point(size = 1, alpha = 0) +
  geom_line(size=0.75,alpha=0.35,aes(group=X.run.number., color=ratio.of.people.using.the.tracking.app, linetype=ratio.of.people.using.the.tracking.app)) +
  geom_smooth(aes(color = ratio.of.people.using.the.tracking.app, linetype=ratio.of.people.using.the.tracking.app),method="loess",size=1.5, span = 0.1, se=TRUE, fullrange=FALSE, level=0.95) +
  #scale_fill_manual(values=c("red1","gray10")) +
  #scale_colour_manual(values=c("red1","gray10")) +
  xlim(0, 500) + 
  ylim(0, 600) +
  #aesthetics for the legend
  guides(colour = guide_legend(override.aes = list(size=5, alpha=1))) +
  xlab("Ticks [4 ticks = 1 day]") +
  ylab("Number of Infected People") + 
  labs(title="Infection Plot",
       subtitle="Infected People & Proportion of App Users", 
       caption="Agent-based Social Simulation of Corona Crisis (ASSOCC)") +
  theme_bw()

#hospital_admissions plot with trendline
ggplot(clean_df, aes(x=X.step., y=X.admissions.last.tick, fill=ratio.of.people.using.the.tracking.app)) +
  geom_line(size=0.75,alpha=0.35,aes(group=X.run.number., color=ratio.of.people.using.the.tracking.app, linetype=ratio.of.people.using.the.tracking.app)) +
  geom_smooth(aes(color = ratio.of.people.using.the.tracking.app, linetype=ratio.of.people.using.the.tracking.app),method="loess",size=1.5, span = 0.1, se=TRUE, fullrange=FALSE, level=0.95) +
#  scale_fill_manual(values=c("pink1","gray10")) +
#  scale_colour_manual(values=c("pink1","gray10")) +
  xlim(0, 500) + 
  ylim(0, 10) +
  #aesthetics for the legend
  guides(colour = guide_legend(override.aes = list(size=5, alpha=1))) +
  xlab("Ticks [4 ticks = 1 day]") +
  ylab("Number of People Hospitalized") + 
  labs(title="Hospitalization Plot",
       subtitle="Hospitalization & Proportion of App Users", 
       caption="Agent-based Social Simulation of Corona Crisis (ASSOCC)") +
  theme_bw()

#taken_hospital_beds plot with trendline
ggplot(clean_df, aes(x=X.step., y=X.taken.hospital.beds, fill=ratio.of.people.using.the.tracking.app)) +
  geom_line(size=0.75,alpha=0.35,aes(group=X.run.number., color=ratio.of.people.using.the.tracking.app, linetype=ratio.of.people.using.the.tracking.app)) +
  geom_smooth(aes(color = ratio.of.people.using.the.tracking.app, linetype=ratio.of.people.using.the.tracking.app),method="loess",size=1.5, span = 0.1, se=TRUE, fullrange=FALSE, level=0.95) +
#  scale_fill_manual(values=c("purple1","gray10")) +
#  scale_colour_manual(values=c("purple1","gray10")) +
  xlim(0, 500) + 
  ylim(0, 100) +
  #aesthetics for the legend
  guides(colour = guide_legend(override.aes = list(size=5, alpha=1))) +
  xlab("Ticks [4 ticks = 1 day]") +
  ylab("Occupied Hospital Beds") + 
  labs(title="Occupied Hospital Beds Plot",
       subtitle="Occupied Hospital Beds & Proportion of App Users", 
       caption="Agent-based Social Simulation of Corona Crisis (ASSOCC)") +
  theme_bw()

#cumulative_deaths plot with trendline
ggplot(clean_df, aes(x=X.step., y=X.dead.people, fill=ratio.of.people.using.the.tracking.app)) +
  geom_line(size=0.75,alpha=0.35,aes(group=X.run.number., color=ratio.of.people.using.the.tracking.app, linetype=ratio.of.people.using.the.tracking.app)) +
  geom_smooth(aes(color = ratio.of.people.using.the.tracking.app, linetype=ratio.of.people.using.the.tracking.app),method="loess",size=1.5, span = 0.1, se=TRUE, fullrange=FALSE, level=0.95) +
#  scale_fill_manual(values=c("gray50","gray10")) +
#  scale_colour_manual(values=c("gray50","gray10")) +
  xlim(0, 500) + 
  ylim(0, 15) +
  #aesthetics for the legend
  guides(colour = guide_legend(override.aes = list(size=5, alpha=1))) +
  xlab("Ticks [4 ticks = 1 day]") +
  ylab("Number of Deaths") + 
  labs(title="Number of Deaths Plot",
       subtitle="Number of Deaths & Proportion of App Users", 
       caption="Agent-based Social Simulation of Corona Crisis (ASSOCC)") +
  theme_bw()

#X.tests.performed plot with trendline
ggplot(clean_df, aes(x=X.step., y=X.tests.performed, fill=ratio.of.people.using.the.tracking.app)) +
  # geom_point(size = 1, alpha = 0) +
  geom_line(size=0.75,alpha=0.35,aes(group=X.run.number., color=ratio.of.people.using.the.tracking.app, linetype=ratio.of.people.using.the.tracking.app)) +
  geom_smooth(aes(color = ratio.of.people.using.the.tracking.app, linetype=ratio.of.people.using.the.tracking.app),method="loess",size=1.5, span = 0.1, se=TRUE, fullrange=FALSE, level=0.95) +
  # scale_colour_gradient(low = "red", high = "gray20") +
#  scale_fill_manual(values=c("blue1","gray10")) +
#  scale_colour_manual(values=c("blue1","gray10")) +
  xlim(0, 500) + 
  ylim(0, 15000) +
  #aesthetics for the legend
  guides(colour = guide_legend(override.aes = list(size=5, alpha=1))) +
  xlab("Ticks [4 ticks = 1 day]") +
  ylab("Number of Tests") + 
  labs(title="Number of Tests Plot",
       subtitle="Tests & Proportion of App Users", 
       caption="Agent-based Social Simulation of Corona Crisis (ASSOCC)") +
  theme_bw()

# Ending of export to pdf
if (export_pdf) {
  dev.off();
}

#line plot
#ggplot(data = clean_df, mapping = aes(x = X.step., y = X.infected, group = X.run.number.)) + 
#  scale_colour_gradient(low = "red", high = "red4") +
#  geom_line(size=1,alpha=1,aes(color=ratio.of.people.using.the.tracking.app)) + 
#  xlab("x-label") +
#  ylab("y-label") + 
#  ggtitle("some title") +
#  labs(title="Title",
#       subtitle="Subtitle", 
#       caption="Agent-based Social Simulation of Corona Crisis (ASSOCC)") +
#  theme_linedraw()