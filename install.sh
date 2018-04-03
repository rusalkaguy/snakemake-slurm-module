#!/bin/bash

if [ "$1" == "-n" ]; then
    FLAGS="$1"
    shift 1
fi

if [ "$1" == "" ]; then
	echo "SYNTAX: $0 target_dir"
	exit 1
fi

if [ ! -d $1 ]; then
	echo "ERROR: not a directory: $1"
	exit 1
fi

exec rsync -hav $FLAGS \
	./snakemakeslurm \
	./cluster.slurm.cheaha.json \
	$1

exec rsync -hav $FLAGS \
	./modulefiles \
        $1/../../modulefiles
