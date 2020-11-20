#!/bin/sh

echo Running ASSOCC Model Simulation - $1

/usr/lib/netlogo/netlogo-headless.sh \
  --model /var/model/simulation_model/covid-sim.nlogo \
  --setup-file /var/model/data/experiments.xml  \
  --experiment $1 \
  --table /var/model/results/$1.csv
