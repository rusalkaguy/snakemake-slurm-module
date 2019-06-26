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

echo "# install exec and config" 
rsync -hav --info=name2,stats0,flist0 $FLAGS \
	./snakemakeslurm \
	./cluster.slurm.cheaha.json \
	$1

echo "# install modulefiles" 
rsync -hav --info=name2,stats0,flist0 $FLAGS \
	./modulefiles/snakemakeslurm \
        $1/../../modulefiles
