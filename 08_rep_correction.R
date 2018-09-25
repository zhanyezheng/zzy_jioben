library(readr)
library(dplyr)
library(ggplot2)



#捕获列表下某一类文件，"ReadsCoverage" 指捕获列表下后缀为ReadsCoverage 的文件
files_list <- list.files("~/project/R-loop/R-chip/analysis/3-genome-coverage","ReadsCoverage")  

files_path <- file.path("~/project/R-loop/R-chip/analysis/3-genome-coverage",files_list)

input_rep1 <- read.table(files_path[1], sep='\t')
input_rep2 <- read.table(files_path[2], sep='\t')
input_rep3 <- read.table(files_path[3], sep='\t')
chip_rep1 <- read.table(files_path[4], sep='\t')
chip_rep2 <- read.table(files_path[5], sep='\t')
chip_rep3 <- read.table(files_path[6], sep='\t')

pw_plot <- function(x, y, 
                    xlab="x",
                    ylab="y", ...){
  log2x <- log2(x)
  log2y <- log2(y)                       #基础绘图系统的光滑散点图(smoothScatter)
  smoothScatter(log2x,log2y,             ##  smoothScatter : Scatterplots with Smoothed Densities Color Representation  表示散点图的一种方法
                cex=1,               ## cex: A numerical value giving the amount by which plotting text and symbols should be magnified relative to the default. 图中小黑点的大小
                xlim=c(0,12),ylim=c(0,12),  #横纵坐标轴的大小        
                xlab=xlab,                 #定义横纵坐标轴的名称
                ylab=ylab)
  text(3,10,paste("R = ",round(cor(x,y),2),sep=""))  # test() 是确定 X Y 相关性放置的位置 ，round(cor(x,y),2) 对相关性值进行四色五入并保留两位小数
}

par(mfrow=c(2,3)) # 规定面板中图的显示方式 （以2行3列的形式呈现）
pw_plot(chip_rep1[,4], chip_rep2[,4],
        xlab = "Rep 1 (Log2 Tag Counts)",
        ylab = "Rep 2 (Log2 Tag Counts)")

pw_plot(chip_rep1[,4], chip_rep3[,4],
        xlab = "Rep 1 (Log2 Tag Counts)",
        ylab = "Rep 3 (Log2 Tag Counts)")

pw_plot(chip_rep2[,4], chip_rep3[,4],
        xlab = "Rep 2 (Log2 Tag Counts)",
        ylab = "Rep 3 (Log2 Tag Counts)")

pw_plot(input_rep1[,4], input_rep2[,4],
        xlab = "Rep 1 (Log2 Tag Counts)",
        ylab = "Rep 2 (Log2 Tag Counts)")

pw_plot(input_rep1[,4], input_rep3[,4],
        xlab = "Rep 1 (Log2 Tag Counts)",
        ylab = "Rep 3 (Log2 Tag Counts)")

pw_plot(input_rep2[,4], input_rep3[,4],
        xlab = "Rep 2 (Log2 Tag Counts)",
        ylab = "Rep 3 (Log2 Tag Counts)")

