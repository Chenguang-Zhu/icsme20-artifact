#!/usr/bin/python3

import os

SCRIPT_DIR = os.path.dirname(os.path.realpath(__file__)) # Dir of this script
OUTPUT_DIR = SCRIPT_DIR + '/../file-level/output'

CONFIGS = ['split-definer', 'split-cslicer-definer', 'cslicer-split-definer', 
           'definer-split-definer', 'cslicer-definer-split-definer', 
           'definer-split-cslicer-definer', 'cslicer-definer-split-cslicer-definer']

def glimpse(example, config, output_dir=OUTPUT_DIR):
    log_file = output_dir + '/' + config + '/' + example + '.log'
    if not os.path.isfile(log_file):
        return
    with open(log_file, 'r') as fr:
        lines = fr.readlines()
    for i in range(len(lines)):
        if lines[i].strip().startswith('[STATS] ************** Stats **************'):
            print(''.join(lines[i-1: len(lines)]))

if __name__ == '__main__':
    for config in CONFIGS:
        print('File: file-level/output/' + config + '/CSV-159.log')
        glimpse('CSV-159', config)
