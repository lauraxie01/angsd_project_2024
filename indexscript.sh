#! /bin/bash -i
#SBATCH --partition=angsd_class
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --job-name=index_creation
#SBATCH --time=06:00:00
#SBATCH --mem=60G

mamba activate angsd

STAR  --runMode genomeGenerate \
      --runThreadN 4 \
      --genomeDir genome_STARindex \
      --genomeFastaFiles /athena/angsd/scratch/ljx4001/genome/GRCh38.primary_assembly.genome.fa \
      --sjdbGTFfile /athena/angsd/scratch/ljx4001/genome/gencode.v45.basic.annotation.gtf.gz \
      --sjdbOverhang 99
