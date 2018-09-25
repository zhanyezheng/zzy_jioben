#!/bin/bash

set -e
set -u
set -o pipefail

samples=${1?please provied sample file}
threads=${2-8}
bs=${3-50}

ALIGN_DIR="../analysis/2-read-align"
BW_DIR="../analysis/4-normliazed-bw"

mkdir -p $BW_DIR

exec 0< $samples
cd $ALIGN_DIR

while read sample
do
    bams=$(ls ${sample}*flt.bam | tr '\n' ' ')
    echo $bams
    if [ ! -f ../$(basename ${BW_DIR})/${sample}.tmp.bam ]; then
    echo "samtools merge -f -@ ${threads} ../$(basename ${BW_DIR})/${sample}.tmp.bam $bams  &&
          samtools index ../$(basename ${BW_DIR})/${sample}.tmp.bam" | bash
    fi
done
