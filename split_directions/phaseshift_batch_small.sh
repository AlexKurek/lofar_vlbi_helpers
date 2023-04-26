#!/bin/bash
#SBATCH -c 10 --job-name=phaseshift --array=0-410 --constraint=amd

#SINGULARITY
SING_BIND=$( python ../parse_settings.py --BIND )
SIMG=$( python ../parse_settings.py --SIMG )

echo "Job landed on $(hostname)"

pattern="*MHz*.parset"
files=( $pattern )
N=$(( ${SLURM_ARRAY_TASK_ID} ))

#RUN
singularity exec -B $SING_BIND $SIMG DP3 ${files[${N}]}
echo "Launched script for ${files[${N}]}"