#!/bin/bash
awk '{print "rename " $2 " " $3   " analysis/0-raw-data/" $2 "*.gz"}' gsm_srr_sample_name.txt |bash