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
projects=("commons-compress"
          "commons-configuration"
          "commons-csv"
          "flume"          
          "commons-io"
          "commons-lang"
          "maven"          
          "commons-net"
          "pdfbox"
)
(
    cd _downloads
    for p in "${projects[@]}"; do
        git clone https://github.com/MSR-2017/$p
        cp -r $p $p-cache
    done
)

# Run all seven optimal sequences on all the 28 functionalities used in our experiment
# Time estimation: ~40.5 hours on a Intel Core i7-8650U CPU @ 1.90GHz × 8 machine with 16 GB RAM
functionalities=('COMPRESS-327'
                 'COMPRESS-369'
                 'COMPRESS-373'
                 'COMPRESS-374'
                 'COMPRESS-375'
                 'CONFIGURATION-624'
                 'CONFIGURATION-626'
                 'CSV-159'
                 'CSV-175'
                 'CSV-179'
                 'CSV-180'
                 'FLUME-2628'
                 'IO-173'
                 'IO-275'
                 'IO-288'
                 'IO-290'
                 'IO-305'
                 'LANG-993'
                 'LANG-1006'
                 'MNG-4904'
                 'MNG-4909'
                 'MNG-4910'
                 'NET-436'
                 'NET-525'
                 'NET-527'
                 'PDFBOX-3069'
                 'PDFBOX-3418'
                 'PDFBOX-3307'
)
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
for f in "${functionalities[@]}"; do
    for c in "${configs[@]}"; do
        time python3 genslice/genslice.py --${c}-one ${f}
    done
done



