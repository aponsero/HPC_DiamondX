#!/bin/bash -l
#SBATCH --job-name=diamondBLAST
#SBATCH --account=
#SBATCH --output=errout/outputr%j.txt
#SBATCH --error=errout/errors_%j.txt
#SBATCH --partition=small
#SBATCH --time=01:00:00
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --cpus-per-task=40
#SBATCH --mem-per-cpu=1000


# load job configuration
cd $SLURM_SUBMIT_DIR
source config_scripts/config.sh

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
diamond blastx --query $INPUT -d $DB --out $RESULTS --outfmt 6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore full_qseq -p 4 --max-target-seqs $MAX_TAR


# echo for log
echo "job done"; date

