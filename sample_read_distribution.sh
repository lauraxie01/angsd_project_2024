#! /bin/bash -l

#SBATCH --partition=angsd_class
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=align_t1d_samples
#SBATCH --time=06:00:00
#SBATCH --mem=10G

mamba activate angsd
mamba activate rseqc

# Path to your BAM files
ALIGNMENT_DIR="/athena/angsd/scratch/ljx4001/project/t1D_data/t1d/sample_alignments"

# Path to your BED file
BED_FILE="/athena/angsd/scratch/ljx4001/genome/hg38_GENCODE_V45_Basic.bed"

# Directory to save output files
OUTPUT_DIR="/athena/angsd/scratch/ljx4001/project/t1D_data/t1d/read_distribution"

# Check if output directory exists, if not create it
if [ ! -d "$OUTPUT_DIR" ]; then
  mkdir -p "$OUTPUT_DIR"
fi

# Loop through all .bam files in the BAM_DIR
for FILE in "$ALIGNMENT_DIR"/*Aligned.sortedByCoord.out.bam
do
  # Extract the base name of the file (without the directory and extension)
  BASE_NAME=$(basename "$FILE" Aligned.sortedByCoord.out.bam)

  # Define output file name
  OUTPUT_FILE="$OUTPUT_DIR/${BASE_NAME}_read_distribution.txt"

  # Run your command
  read_distribution.py -i "$FILE" -r "$BED_FILE" > "$OUTPUT_FILE"

  echo "Processed $FILE, output saved to $OUTPUT_FILE"
done
