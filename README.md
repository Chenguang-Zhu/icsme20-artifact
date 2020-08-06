# GenSlice

**GenSlice** is a generalized semantic history slicing framework which puts several history
slicing techniques (including [CSlicer](https://github.com/ntu-SRSLab/CSlicer) and Definer) 
developed over the years under a uniform lens
and provides a systematic approach for comparisons and analyses.

### Quick Start

#### 1. Build Docker image

```bash
docker build -f Dockerfile -t genslice .
```

#### 2. Run demo case

We demonstrate the history slicing operator sequences on one example: CSV-159.  
Time estimation: ~20 mins on an Intel Core i7-8650U CPU @ 1.90GHz × 8 machine with 16 GB RAM.

```bash
docker run --name genslice-demo -i -t genslice --rm -v `pwd`:/Scratch
./run_demo.sh
```

This script executes all the seven optimal sequences (SD, SCD, CSD, DSD, CDSD, DSCD, CDSCD) and stores their semantic history slicing results in corresponding log files:  
- file-level/output/split-definer/CSV-159.log
- file-level/output/split-cslicer-definer/CSV-159.log
- file-level/output/cslicer-split-definer/CSV-159.log
- file-level/output/definer-split-definer/CSV-159.log
- file-level/output/cslicer-definer-split-definer/CSV-159.log
- file-level/output/definer-split-cslicer-definer/CSV-159.log
- file-level/output/cslicer-definer-split-cslicer-definer/CSV-159.log

The end of each log file looks like the following:

```text
[OUTPUT] |H*| = 2  
[STATS] ************** Stats **************  
[STATS] history.preprocess : 0.732  
[STATS] insert.edge : 0.0  
[STATS] total : 19.508  
[STATS] total.time : 20.59  
[STATS] test.run : 3.52  
[STATS] extract.time : 0.0  
[STATS] call.graphs : 0.212  
[STATS] hunk.fail : 2  
[STATS] pre.comp.fail : 14  
[STATS] test : 5  
[STATS] hstar.length : 2  
[STATS] iteration : 6  
[STATS] ***********************************  
[Split Exec Time]: 82.60289740562439  
[CSlicer Exec Time]: 29.742250204086304  
[Definer Exec Time]: 31.010393381118774  
[Total Exec Time]: 143.35554242134094  
Total Changed Lines: 81
```

The last line shows the size of the final history slice, measured in
number of changed (+/-) lines. For CSV-159, you will see that all the
seven log files have the same number: 81.

The result means that in this case, all seven optimal sequences yield
the same result, which is 1-minimal semantic history slice.

#### 3. Reproduce full experiment results for all cases presented in the paper

Run all the sequences (RQ2 and RQ3) on all the 28 functionalities used in our experiment.  
Time estimation: ~40.5 hours on an Intel Core i7-8650U CPU @ 1.90GHz × 8 machine with 16 GB RAM.

```bash
docker run --name genslice-all -i -t genslice --rm -v `pwd`:/Scratch
./run_all.sh
```

This script executes 13 sequences (C, D, SC, CD, DSC, CDSC, SD, SCD,
CSD, DSD, CDSD, DSCD, CDSCD) on all 28 functionalities and stores
their semantic history slicing results in corresponding log
files. Each log file has the same structure as the above example.


Some extra results are available on GenSlice website (<https://sites.google.com/view/genslice>).

If you would like to use GenSlice in your research, please cite our ICSME'20 paper.

```latex
@inproceedings{Zhu2020GGS,
  author = {Zhu, Chenguang and Li, Yi and Rubin, Julia and Chechik, Marsha},
  booktitle = {Proceedings of the 36th IEEE International Conference on Software Maintenance and Evolution (ICSME)},
  month = sep,
  title = {{GenSlice}: Generalized Semantic History Slicing},
  year = {2020}
}
```
