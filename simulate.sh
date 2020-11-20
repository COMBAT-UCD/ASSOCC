#!/bin/sh

EXP=$1
CORES=$2
if [ $# -ne 2 ]; then
    CORES=1
fi

echo "Running ASSOCC Model Simulation - $EXP ($CORES threads)"

/usr/lib/netlogo/netlogo-headless.sh \
  --model /var/model/simulation_model/covid-sim.nlogo \
  --setup-file /var/model/data/experiments.xml \
  --threads $CORES \
  --experiment $EXP \
  --table /var/model/results/$EXP.csv
