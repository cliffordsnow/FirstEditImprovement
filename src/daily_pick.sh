#!/bin/bash

N=5

QUALITY=/home/clifford/Development/FirstEditImprovement
cd ${QUALITY}/quality

if test -e picks.csv;then
	rm picks.csv
fi

if test -e changeset.txt; then
	shuf -n $N changeset.txt > picks.txt
	python ${QUALITY}/src/api2csv.py
#	rm ${QUALITY}/quality/changeset.txt
fi


