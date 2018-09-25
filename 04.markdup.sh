#!/bin/bash

set -e
set -u
set -o pipefail

# configuration
threads=8
index=/f/mulinlab/zhanye/hic/00_hg19/bowtie2/hg19
FQ_DIR="/f/mulinlab/zhanye/project/R-loop/R-chip/analysis/0_raw_data_sample"
OUT_DIR="/f/mulinlab/zhanye/project/R-loop/R-chip/analysis/2-read-align"
LOG_DIR="/f/mulinlab/zhanye/project/R-loop/R-chip/analysis/log"
TMP_DIR="/f/mulinlab/zhanye/project/R-loop/R-chip/analysis/tmp"

mkdir -p ${OUT_DIR}
mkdir -p ${LOG_DIR}
mkdir -p ${TMP_DIR}

samples=${1?missing sample file}

exec 0< $samples
# mark duplication
while read id;
do
    if [ ! -f ${OUT_DIR}/${id}.mkdup.done ]
    then
    echo "sambamba markdup -t $threads ${OUT_DIR}/${id}.sort.bam ${OUT_DIR}/${id}.mkdup.bam \
    && touch ${OUT_DIR}/${id}.mkdup.done" | bash
    fi
done
