# snakemake-slurm-module

On the UAB computing cluster "cheaha" this module sits on top of snakemake and automates setting of all the needed SLURM properties for the --cluster flag, so that snakemake can be run in cluster mode with minimum work. It also loads support modules:
  * Anaconda3
  * Singularity


```
module load snakemakeslurm
snakemakeslurm
```

The module contiains
* [snakemakeslurm](snakemakeslurm) - builds the --cluster commandline based on snakemake docs on (cluster-execution](http://snakemake.readthedocs.io/en/stable/executable.html#cluster-execution)
* [cluster.slurm.cheaha.json](cluster.slurm.cheaha.json) - defines all SLURM parameters for a default job: 1 core, 2G ram, 2 hours, express partition



SYNTAX: snakemakeslurm [--debug] [snakemake flags]

EXAMPLE:
```
module load snakemakeslurm
snakemakeslurm  --debug -p all
CMD: snakemake \
     --latency-wait 45 --jobs 999 \
     --cluster-config /share/apps/ngs-ccts/snakemakeslurm/snakemakeslurm-5.9.1-1/cluster.slurm.cheaha.json \
     --cluster-config ./cluster.json \
     --cluster sbatch  \
     --cpus-per-task {threads} --mem-per-cpu {cluster.mem-per-cpu-mb} \
     --mail-user ${USER}@uab.edu --job-name {cluster.job-name} \
     --ntasks {cluster.ntasks} --partition {cluster.partition} \
     --time {cluster.time} --mail-type {cluster.mail-type} \
     --error {cluster.error} --output {cluster.output} \
     -p all
```

Notice:
 * it has defined (mostly 1-to-1) name mappings for SLURM attributes to keys in the cluster.json file
 * it has populated "--mail-user $USER@uab.edu"
 * it has mapped rule.threads to SLURM:--cpus-per-task
 * the default job name is "SM.{rule}.{wildcards}" (defined in [cluster.slurm.cheaha.json](cluster.slurm.cheaha.json))

It loads the following cluster json files in order (and you can always add more):
 * module/cluster.slurm.cheaha.json
 * ./cluster.slurm.cheaha.json
 * ./cluster.json
 * ./slurm-config.yaml
 
