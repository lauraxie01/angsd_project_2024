#! /bin/bash -l

#SBATCH --partition=angsd_class
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --job-name=align_ctrl_samples
#SBATCH --time=10:00:00
#SBATCH --mem=20G


mamba activate angsd



CTRL_SAMPLES_FILE="/athena/angsd/scratch/ljx4001/project/t1D_data/ctrl/control_list.txt" 
GENOME_DIR="/athena/angsd/scratch/ljx4001/genome/genome_STARindex"
OUTPUT_DIR="/athena/angsd/scratch/ljx4001/project/t1D_data/ctrl/control_alignments"

mkdir -p "$OUTPUT_DIR"


while IFS= read -r SAMPLE_ID; do
    fastqc "${SAMPLE_ID}_1.fastq.gz" --extract -o "$OUTPUT_DIR"
    fastqc "${SAMPLE_ID}_2.fastq.gz" --extract -o "$OUTPUT_DIR"
    
    echo "Processing $SAMPLE_ID"
    OUTPUT_PREFIX="${OUTPUT_DIR}/${SAMPLE_ID}"

   
    STAR --runMode alignReads \
         --runThreadN 4 \
         --genomeDir "$GENOME_DIR" \
         --readFilesIn "${SAMPLE_ID}_1.fastq.gz" "${SAMPLE_ID}_2.fastq.gz" \
         --readFilesCommand zcat \
         --outFileNamePrefix "$OUTPUT_PREFIX" \
         --outSAMtype BAM SortedByCoordinate

done < "$CTRL_SAMPLES_FILE"

