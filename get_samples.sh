#! /bin/bash -l

#SBATCH --partition=angsd_class
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=get_samples
#SBATCH --time=01:00:00
#SBATCH --mem=5G

base_url="ftp://ftp.sra.ebi.ac.uk/vol1/fastq/"

while IFS= read -r accession_number; do
   suffix="${accession_number: -2}"
   url="${base_url}${accession_number:0:6}/0${suffix}/${accession_number}/${accession_number}_1.fastq.gz"
   wget "$url"
   sleep 1
done < "sample_list.txt"
