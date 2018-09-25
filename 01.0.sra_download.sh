#!/bin/bash
sra_file = ${1?missing input file}
sra_ids= $(egrep -o 'SRR[0-9]{5,9}' $sra_files)
mkdir -p analysis/log
for id in $sra_ids
do
    prefetch $id >> analysis/log/download.log
done