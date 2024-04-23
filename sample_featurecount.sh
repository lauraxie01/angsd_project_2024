#! /bin/bash -l

#SBATCH --partition=angsd_class
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=align_t1d_samples
#SBATCH --time=01:00:00
#SBATCH --mem=10G

mamba activate angsd

# Use find to generate a list of bam files and save it to a variable
bam_files=$(find /athena/angsd/scratch/ljx4001/project/t1D_data/t1d/sample_alignments/ -name "*.bam" | tr '\n' ' ')

# Use the variable in the featureCounts command
featureCounts -a /athena/angsd/scratch/ljx4001/genome/gencode.v45.basic.annotation.gtf.gz -T 4 \
-o /athena/angsd/scratch/ljx4001/project/t1D_data/t1d/feature_counts/counts.txt -g gene_id -t exon -B -C -p $bam_files



