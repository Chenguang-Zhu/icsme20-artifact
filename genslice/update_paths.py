#!/usr/bin/python3

import os

SCRIPT_DIR = os.path.dirname(os.path.realpath(__file__)) # Dir of this script
ORIG_CONFIGS_DIR = SCRIPT_DIR + '/../file-level/orig-configs'
DEFINER_CONFIGS_DIR = SCRIPT_DIR + '/../file-level/definer-configs'
CONFIGS_DIR = SCRIPT_DIR + '/../file-level/configs'

def findAllConfigFiles():
    all_config_files = []
    for dir_path, subpaths, files in os.walk(ORIG_CONFIGS_DIR):
        for f in files:
            if f.endswith('.properties'):
                path = dir_path + '/' + f
                if path not in all_config_files:
                    all_config_files.append(path)
    for dir_path, subpaths, files in os.walk(DEFINER_CONFIGS_DIR):
        for f in files:
            if f.endswith('.properties'):
                path = dir_path + '/' + f
                if path not in all_config_files:
                    all_config_files.append(path)
    for dir_path, subpaths, files in os.walk(CONFIGS_DIR):
        for f in files:
            if f.endswith('.properties'):
                path = dir_path + '/' + f
                if path not in all_config_files:
                    all_config_files.append(path)                    
    return all_config_files

def replacePathForOneFile(config_file, new_path):
    with open(config_file, 'r') as fr:
        lines = fr.readlines()
    for i in range(len(lines)):
        lines[i] = lines[i].replace('/home/cgzhu/projects/icsme20-artifact/genslice',
                                    new_path)
    with open(config_file, 'w') as fw:
        fw.write(''.join(lines))

if __name__ == '__main__':
    all_config_files = findAllConfigFiles()
    #print ('\n'.join(all_config_files))
    for f in all_config_files:
        replacePathForOneFile(f, '/home/genslice')
    
