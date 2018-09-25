#!/usr/bin/perl

use warnings;
use strict;
use utf8;
use File::Basename;


my $dir = "/f/mulinlab/zhanye/project/R-loop/R-chip/analysis/0-raw-data";
my $do = "/f/mulinlab/zhanye/project/R-loop/R-chip/analysis/0_raw_data_sample";
mkdir $do unless -d $do;

my $fi = "./gsm_srr_sample_name.txt";
open my $I , '<' , $fi or die "$0 : failed to open inout file '$fi' : $!\n ";

my %hash;
while (<$I>) {
    chomp;
    my @f = split/\s+/;
    my $srr = $f[1];
    my $sample = $f[2];
    $hash{$srr} = $sample ;
}

my @srrs = glob "$dir/*.gz";
foreach my $srr (@srrs) {
     my $bn = basename($srr) ; 
     $bn =~ s/\.fastq.gz//;
    if (exists $hash{$bn}) {
        my $fo = "$do/$hash{$bn}" . ".fastq.gz";
        link ($srr,$fo);
    }
    else{
         print STDERR "ID not exist:\t$srr\n";
    }     
 }