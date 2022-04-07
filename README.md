# HPC_DiamondX
Pipeline for parrallel submission of BLASTX diamond jobs (SLURM scheduler)

## Installation and prerequisites

Installation of Diamond v2.0.14 is required. On CSC Puhti, the tool is pre-installed in the module biokit).

If the system doesn't have Diamond install, a conda environment can be created as followed: 

```
conda create -n diamond_env
conda activate diamond_env
conda install -c bioconda diamond
conda deactivate
```

Next, clone this repository on your working folder:

```
git clone https://github.com/aponsero/HPC_DiamondX.git
```

## Creating a custom Diamond database

Diamond provides an easy and fast way to create a custom protein database of reference.

### 1. Upload to the working directory a protein fasta file. **Beware, make sure to remove any extra spaces or trailing spaces from the file. Extra spaces or incorrectly formated fasta file will stop the database building job**

### 2. Request an interactive node to run the command. In Puhti CSC:

```
sinteractive
```

### 3. Run the database building command:

```
module load biokit

diamond makedb --in [my_references.faa] -d [NAME_DATABASE] -p 4
``` 

If the command worked, you should now have a NAME_DATABASE.dmnd file created.

**CSC has some database pre-indexed, see https://docs.csc.fi/apps/diamond/ for more informations**

### 4. Edit the config.sh file as followed:

Inputs and output files:

[IN_DIR]= Input directory with the fasta samples to process
[OUT_DIR]= Output directory where to save the diamond output

Diamond configurations:

[DB]= custom or non-custom diamond database to use
[MAX_TAR]= max targets match per query

### 5. Modify the list_to_process.txt file.

This imput file needs to contain the list of files you want to process. Each file on one line.

### 6. Submit job

Open the 1_Diamond.sh file and add the correct project ID for billing.
Submit the jobs as:

```
./Submit_Diamond.sh
```

