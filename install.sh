#!/bin/bash

#
# typical usage
# 
# mkdir ../snakemakeslurm-5.2.4-1
# ./install.sh $!
#

if [ "$1" == "-n" ]; then
    FLAGS="$1"
    shift 1
fi

if [ "$1" == "" ]; then
	echo "SYNTAX: $0 target_dir"
	echo ""
	echo "example:"
	latestver=$(cd modulefiles/snakemakeslurm/; ls -1 | tail -1)
        echo "mkdir ../snakemakeslurm-${latestver}"
        echo "$0 ../snakemakeslurm-${latestver}"
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
