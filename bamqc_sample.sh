#! /bin/bash -l

#SBATCH --partition=angsd_class
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=align_t1d_samples
#SBATCH --time=10:00:00
#SBATCH --mem=20G

mamba activate angsd
mamba activate qualimap

# Path to your BAM files
ALIGNMENT_DIR="/athena/angsd/scratch/ljx4001/project/t1D_data/t1d/sample_alignments"
RESULT_DIR="/athena/angsd/scratch/ljx4001/project/t1D_data/t1d/bamqc_results"
# Loop through all .bam files in the BAM_DIR
for FILE in "$ALIGNMENT_DIR"/*Aligned.sortedByCoord.out.bam
do
  BASE_NAME=$(basename "$FILE" .bam)
  RESULT_PDF="$RESULT_DIR/${BASE_NAME}.pdf"
  if [ -f "$RESULT_PDF" ]; then
    echo "QC already done for $FILE, skipping..."
    continue
  fi
  # Run your command
    qualimap bamqc -bam "$FILE" --outdir /athena/angsd/scratch/ljx4001/project/t1D_data/t1d/bamqc_results --outfile "${BASE_NAME}".pdf
done



