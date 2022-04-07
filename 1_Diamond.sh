#!/bin/bash -l
#SBATCH --job-name=diamondBLAST
#SBATCH --account=project_2004512
#SBATCH --output=errout/outputr%j.txt
#SBATCH --error=errout/errors_%j.txt
#SBATCH --partition=small
#SBATCH --time=24:00:00
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --cpus-per-task=40
#SBATCH --mem-per-cpu=1000


# load job configuration
cd $SLURM_SUBMIT_DIR
source config.sh

# load environment
module load biokit

# echo for log
echo "job started"; hostname; date

# Get sample ID
export SAMPLE=`head -n +${SLURM_ARRAY_TASK_ID} $IN_LIST | tail -n 1`

# create output directories
if [[ ! -d "$OUT_DIR" ]]
then
        mkdir $OUT_DIR
fi

# run diamond
RESULTS="$OUT_DIR/${SAMPLE}_diamond.txt"
INPUT="$IN_DIR/${SAMPLE}"
diamond blastx --query $INPUT -d $DB --out $RESULTS -p 4 --max-target-seqs $MAX_TAR


# echo for log
echo "job done"; date

