#!/bin/bash
#SBATCH -N 1 -c 4 --job-name=subtract_main

echo "Job landed on $(hostname)"

re="L[0-9][0-9][0-9][0-9][0-9][0-9]"
if [[ $PWD =~ $re ]]; then OBSERVATION=${BASH_REMATCH}; fi

DELAYCAL_RESULT=/project/lofarvwf/Share/jdejong/output/ELAIS/${OBSERVATION}/delaycal/Delay-Calibration
SIMG=/project/lofarvwf/Software/singularity/lofar_sksp_v3.4_x86-64_generic_noavx512_ddf.sif

mkdir -p Input

echo "Copy Delay-Calibration data to Input"

cp -r ${DELAYCAL_RESULT}/${OBSERVATION}*.msdpppconcat Input

mkdir -p subtract_lotss

#echo "Make boxfile: boxfile.reg with /home/lofarvwf-jdejong/scripts/lofar-highres-widefield/utils/make_box.py"

#singularity exec -B $PWD,/project,/home/lofarvwf-jdejong/scripts $SIMG python /home/lofarvwf-jdejong/scripts/prefactor_helpers/helper_scripts/make_box.py Input/*.msdpppconcat 2.5

echo "SUBTRACT SETUP FINISHED"

sbatch /home/lofarvwf-jdejong/scripts/prefactor_helpers/subtract_lotss/subtraction_parallel.sh