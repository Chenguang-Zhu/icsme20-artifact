#!/bin/bash

# Create directories to store final and intermediate results 
mkdir -p file-level/orig-history
mkdir -p file-level/temp-files
mkdir -p file-level/temp-logs
mkdir -p file-level/temp-configs
mkdir -p file-level/_split_logs
mkdir -p file-level/jacoco-files
mkdir -p file-level/_repos
mkdir -p file-level/output
mkdir -p file-level/touchset
mkdir -p _downloads
configs=("cslicer"
         "definer"
         "split-cslicer"
         "cslicer-definer"
         "definer-split-cslicer"
         "cslicer-definer-split-cslicer"
         "split-definer"
         "split-cslicer-definer"
         "cslicer-split-definer"
         "definer-split-definer"
         "cslicer-definer-split-definer"
         "definer-split-cslicer-definer"
         "cslicer-definer-split-cslicer-definer"
)
for c in "${configs[@]}"; do
    mkdir -p file-level/output/$c
done

# Download and cache repo from DoSC dataset: https://github.com/Chenguang-Zhu/DoSC
(
    cd _downloads
    git clone https://github.com/MSR-2017/commons-csv
    cp -r commons-csv commons-csv-cache
)

# Run operator sequence on one functionality: CSV-159
# Time estimation: ~20 min on a Intel Core i7-8650U CPU @ 1.90GHz × 8 machine with 16 GB RAM
configs=("split-definer"
         "split-cslicer-definer"
         "cslicer-split-definer"
         "definer-split-definer"
         "cslicer-definer-split-definer"
         "definer-split-cslicer-definer"
         "cslicer-definer-split-cslicer-definer"
)
for c in "${configs[@]}"; do
    time python3 genslice/genslice.py --${c}-one CSV-159
done

# Extract results from log files
python3 genslice/glimpse.py

