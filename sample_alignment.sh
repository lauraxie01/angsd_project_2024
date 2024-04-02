#! /bin/bash -l

#SBATCH --partition=angsd_class
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --job-name=align_t1d_samples
#SBATCH --time=10:00:00
#SBATCH --mem=20G

mamba activate angsd


GENOME_DIR="/athena/angsd/scratch/ljx4001/genome/genome_STARindex"
T1D_SAMPLES_FILE="/athena/angsd/scratch/ljx4001/project/t1D_data/t1d/sample_list.txt"  
OUTPUT_DIR="/athena/angsd/scratch/ljx4001/project/t1D_data/t1d/sample_alignments"       

mkdir -p "$OUTPUT_DIR"

while IFS= read -r SAMPLE_ID; do
    echo "Processing $SAMPLE_ID"
    fastqc "${SAMPLE_ID}_1.fastq.gz" --extract -o "$OUTPUT_DIR"
    fastqc "${SAMPLE_ID}_2.fastq.gz" --extract -o "$OUTPUT_DIR"

    
    OUT_PREFIX="${OUTPUT_DIR}/${SAMPLE_ID}"

    
    STAR --runMode alignReads \
         --runThreadN 4 \
         --genomeDir "$GENOME_DIR" \
         --readFilesIn "${SAMPLE_ID}_1.fastq.gz" "${SAMPLE_ID}_2.fastq.gz" \
         --readFilesCommand zcat \
         --outFileNamePrefix "$OUT_PREFIX" \
         --outSAMtype BAM SortedByCoordinate

done < "$T1D_SAMPLES_FILE"

