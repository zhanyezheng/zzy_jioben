#!/bin/bash

set -e
set -u
set -o pipefail

# configuration
threads=8
index=/f/mulinlab/zhanye/hic/00_hg19/bowtie2/hg19
FQ_DIR="/f/mulinlab/zhanye/project/R-loop/R-chip/analysis/0-raw-data"
ALIGN_DIR="/f/mulinlab/zhanye/project/R-loop/R-chip/analysis/2-read-align"
LOG_DIR="/f/mulinlab/zhanye/project/R-loop/R-chip/analysis/log"
TMP_DIR="/f/mulinlab/zhanye/project/R-loop/R-chip/analysis/tmp"

mkdir -p ${ALIGN_DIR}
mkdir -p ${LOG_DIR}
mkdir -p ${TMP_DIR}

samples=${1?missing sample file}

exec 0< $samples
# filter
while read id;
do
    if [ ! -f ${ALIGN_DIR}/${id}.flt.done ]
    then
    echo "
    samtools view -@ threads -bF 1804 -q 30 ${ALIGN_DIR}/${id}.mkdup.bam -o ${ALIGN_DIR}/${id}.flt.bam\
    && samtools index ${ALIGN_DIR}/${id}.flt.bam \
    && touch ${ALIGN_DIR}/${id}.flt.done "| bash
    fi
done

#       samtools view 参数设置： 
#       -b：输出文件为bam格式；
#       -t：FILE，一个制表分隔符的文件，对ref.fa使用命令“samtools faidx <ref.fa>”后，获得索引文件ref.fa.fai，使用此索引文件即可；
#       -S：提高与以前samtools版本的兼容性；
#       -F：INT，获得mapped过滤设置，0为未设置；
#       -f：INT，获得unmapped过滤设置，0为未设置；
#       -h：输出中包含头信息；
#       -o：设置输出文件名；
#       -T：FILE，使用fa格式的参考序列，可以使用bgzip格式的文件和使用samtools faidx命令获取的索引文件；
