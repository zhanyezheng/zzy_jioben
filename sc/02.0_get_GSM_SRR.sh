#!/bin/bash
less download_table.txt | cut -f 6,8 | perl -ane 'chomp;unless (/^Run/){print "$_\n"}' | sort -u > 13_gsm_srr_sample_name.txt