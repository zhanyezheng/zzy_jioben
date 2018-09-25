#!/bin/bash

set -e
set -u
set -o pipefail

samples=${1?missing sample file}
threads=8
OUT_DIR="/f/mulinlab/zhanye/project/R-loop/R-chip/analysis/2-read-align"
ALIGN_DIR="/f/mulinlab/zhanye/project/R-loop/R-chip/analysis/2-read-align"

echo -e "Experiment \t Raw Reads \t Uniquely mapped Reads \t ratio"
exec 0< $samples

while read sample;
do
     total=$( samtools view -@ ${threads} -c ${ALIGN_DIR}/${sample}.sort.bam )
     unique=$( samtools view -@ ${threads} -c ${ALIGN_DIR}/${sample}.flt.bam )
     ratio=$( echo "scale=2; 100 * $unique / $total " | bc )
     echo -e "$sample \t $total \t $unique \t $ratio %"
done
