# script to merge diamond outputs in a unique table
library(tidyverse)

args<-commandArgs(TRUE)

## Input files and directories
diamond_dir=args[1]
#read_counts <- read.csv("read_counts.csv")

## Input parameters
min_pid= as.numeric(args[2])
max_eval= as.numeric(args[3])


# get filenames 
profiles <- sort(list.files(diamond_dir, pattern="_diamond.txt", full.names = TRUE))

all_data <- tibble(
  query_id = character(),
  target_id = character(),
  percent_id = numeric(),
  length = numeric(),
  mismatch = numeric(),
  gapopen = numeric(),
  qstart = numeric(),
  qend = numeric(),
  sstart = numeric(),
  send = numeric(),
  evalue = numeric(),
  bitscore = numeric(),
  file = character()
)

mycol_names <- c("query_id","target_id","percent_id", "length", "mismatch","gapopen","qstart",
               "qend","sstart","send","evalue","bitscore")
for(f in profiles) {
  # read profile + select read counts and taxID
  name <- sapply(strsplit(basename(f), "_diamond.txt"), `[`, 1)
  curr_profile <- read_tsv(f, col_names=mycol_names) %>% mutate(file=name)
  
  # add rows
  all_data <- all_data %>% add_row(curr_profile)
  
}

# filter according to parameters
filt_data <- all_data %>% filter(percent_id>min_pid) %>% 
  filter(evalue<max_eval)

# pivot counts
filt_counts <- filt_data %>% group_by(target_id, file) %>% tally()
final_table <- filt_counts %>% 
  pivot_wider(names_from = file, values_from = n, values_fill = 0)

# print count table
write.csv(final_table, paste(diamond_dir, "count_table.csv", sep="/"))


