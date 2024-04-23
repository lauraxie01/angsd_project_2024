#! /bin/bash -l
#SBATCH --partition=angsd_class
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=8
#SBATCH --job-name=rseqc_extra
#SBATCH --time=02:00:00
#SBATCH --mem=50G

mamba activate angsd
mamba activate rseqc

bam_stat.py  -i /athena/angsd/scratch/ljx4001/project/t1D_data/t1d/sample_alignments/*.bam > bam_stats.txt



