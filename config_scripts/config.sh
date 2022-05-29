#!/bin/bash -l
# INPUT LIST and  DIRECTORY
IN_DIR="" # Input directory with samples to process
OUT_DIR="$IN_DIR/diamond_results" # Output directory where to save the diamond output
IN_LIST="config_scripts/list_to_process.txt" # DO NOT MODIFY
# Diamond configurations
DB="databases/FLDB_05.22.dmnd" # custom or non-custom database to use
MAX_TAR=1 # max targets match per query
# Parameters for merging results
min_pid=80
max_eval=0.000001 
