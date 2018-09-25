#!/bin/bash
paste <(egrep -o 'GSM[0-9]{6,9}' download_table.txt) <(egrep -o 'SRR[0-9]{6,9}' download_table.txt) > gsm_srr.txt
join <(sort gsm_srr.txt) <(head -n 24 sample_name.txt | sort) > gsm_srr_sample_name.txt