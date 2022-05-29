#!/bin/bash -l

# load job configuration
source config_scripts/config.sh

#
#makes sure sample file is in the right place
#

if [[ ! -d "errout" ]]; then
	mkdir errout
fi

# submit script
echo "launching 2_merge_results.sh as a job."

JOB_ID=`sbatch --job-name merge config_scripts/2_merge_results.sh`

