library(Gviz)

#下面将scale等track写入tracklist
tracklist<-list()
itrack <- IdeogramTrack(genome = "hg19", chromosome = 'chr16',outline=T)
tracklist[["itrack"]]<-itrack

# 读取BigWig
bw_file_path <- "C:/Users/DELL/Desktop/FigureYa/R-ChIP/"
bw_file_names <- list.files(bw_file_path, "*.bw")
bw_files <- file.path("C:/Users/DELL/Desktop/FigureYa/R-ChIP/",
                      bw_file_names)

tracklist[['D210-fwd']] <- DataTrack(range = bw_files[3],
                              genome="hg19",
                              type="histogram",
                              name='D210 + ',
                              ylim=c(0,4),
                              col.histogram="#2167a4",
                              fill.histogram="#2167a4")
tracklist[['D210-rvs']] <- DataTrack(range = bw_files[4],
                                     genome="hg19",
                                     type="histogram",
                                     name='D210 - ',
                                     ylim=c(4,0),
                                     col.histogram="#eb1700",
                                     fill.histogram="#eb1700")

tracklist[['WKDD-fwd']] <- DataTrack(range = bw_files[9],
                                     genome="hg19",
                                     type="histogram",
                                     name='WKDD + ',
                                     ylim=c(0,4),
                                     ylab=2,
                                     col.histogram="#2167a4",
                                     fill.histogram="#2167a4")
tracklist[['WKDD-rvs']] <- DataTrack(range = bw_files[10],
                                     genome="hg19",
                                     type="histogram",
                                     name=' WKDD -',
                                     ylim=c(4,0),
                                     col.histogram="#eb1700",
                                     fill.histogram="#eb1700",
                                     showAxis=TRUE)

#写入比例尺
scalebar <- GenomeAxisTrack(scale=0.25,
                            col="black",
                            fontcolor="black",
                            name="Scale",
                            labelPos="above",showTitle=F)
tracklist[["scalebar"]]<-scalebar

# 画图
plotTracks(trackList = tracklist,
           chromosome = "chr16",
           from =  69141913, to= 69205033,
           background.panel = "#f6f6f6",
           background.title = "white",
           col.title="black",col.axis="black",
           rot.title=0,cex.title=0.5,margin=10,title.width=1.75,
           cex.axis=1
           )
