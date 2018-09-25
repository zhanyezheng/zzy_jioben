#!/bin/bash

set -e
set -u
set -o pipefail

# configuration
threads=8
index=/f/mulinlab/zhanye/hic/00_hg19/bowtie2/hg19
FQ_DIR="/f/mulinlab/zhanye/project/R-loop/R-chip/analysis/0_raw_data_sample"
ALIGN_DIR="/f/mulinlab/zhanye/project/R-loop/R-chip/analysis/2-read-align"
LOG_DIR="/f/mulinlab/zhanye/project/R-loop/R-chip/analysis/log"
TMP_DIR="/f/mulinlab/zhanye/project/R-loop/R-chip/analysis/tmp"

mkdir -p ${ALIGN_DIR}
mkdir -p ${LOG_DIR}
mkdir -p ${TMP_DIR}

samples=${1?missing sample file}

exec 0< $samples  # 0 标准输入 exec 0< $samples将samples 文件中的内容读到标准输入
# alignment
while read id;    # read 从标准输入中一行一行读取数据，也可以读取键盘输入
do
    if [ ! -f ${FQ_DIR}/$id.bt2.done ]
    then                                                                                      #2> ${LOG_DIR}/$id.bt2.log 将错误输出到log文件中
    echo "bowtie2 --very-sensitive-local --mm -p $threads -x $index -U ${FQ_DIR}/$id.fastq.gz 2> ${LOG_DIR}/$id.bt2.log | \ 
    samtools sort -@ 2 -m 1G -T ${TMP_DIR}/${id} -o ${ALIGN_DIR}/${id}.sort.bam \
    && touch ${ALIGN_DIR}/$id.bt2.done" | bash          # touch 建立一个新文件
    fi
done
                                                            # -1 <m1> 双末端测寻对应的文件1。
                                                            # -2 <m2> 双末端测寻对应的文件2. 
                                                            # -U <r> 非双末端测寻对应的文件。

## echo 内容不传给bash 检查 03.r_chip_align.sh脚本要执行的内容
# sed -i s/|bash/#|bash/ 03.r_chip_align.sh     -i∶ 直接修改读取的档案内容，而不是由萤幕输出。
## 恢复  03.r_chip_align.sh 脚本中要执行的内容
# sed -i s/#|bash/|bash/ 03.r_chip_align.sh 