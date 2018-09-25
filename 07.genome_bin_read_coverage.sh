#!/bin/bash

#BAM相关性评估
#上一步得到各个样本的BAM文件之后，就可以在全基因组范围上看看这几个样本之间是否有差异。也就是先将基因组分成N个区间，然后用统计每个区间上比对上的read数。

set -e
set -u
set -o pipefail

samples=${1?missing sample file}    # 从命令行捕获$1 的输入文件 ?的作用是当忘记输入 文件时，会输出 ? 后面的提醒内容
chromsize=${2:-/f/mulinlab/zhanye/hic/00_hg19/hg19.chrom.sizes}  # : 是指直接从后面的路径下捕获这个变量
size=${3:-3000}
ALIGN_DIR="../analysis/2-read-align"
COV_DIR="../analysis/3-genome-coverage"

mkdir -p ${COV_DIR}

exec 0< $samples

while read sample
do
    bedtools makewindows -g $chromsize -w $size | \
      bedtools intersect -b ${ALIGN_DIR}/${sample}.flt.bam -a - -c -bed > ${COV_DIR}/${sample}.ReadsCoverage
done
