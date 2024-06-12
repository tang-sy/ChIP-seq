# Chip-Seq Analysis of CONSTANS-Like Family Transcription Factors in Maize

## Project Overview
This project involves the analysis of ChIP-Seq data for five transcription factors (TFs) of the CONSTANS-like family in maize. The primary finding of this analysis is that the peak scores in overlapping regions of these TFs are higher than in non-overlapping regions.

## Table of Contents
- [Data](#data)
- [Methods](#methods)
- [Results](#results)
- [Usage](#usage)
- [Contributors](#contributors)
- [License](#license)

## Data
The ChIP-Seq data for the five TFs were obtained from publicly available datasets. Specific accession numbers and download links can be found in the `data/` directory. The reference genome(B73 RefGen_v5) and annotation .gff file were downloaded from [MaizeGDB](https://maizegdb.org/assembly).

## Methods
![[workflow.png]]
### Data Preprocess
The raw ChIP-Seq data files were downloaded from the NCBI database.SRA accession numbers are listed in `data/SRR_Acc_List.txt`. FastQC was used for quality check. 

### Alignment
Reads were mapped to the unmasked maize genome (B73 RefGen_v5) using Bowtie 2 (v2.4.1) under the default parameters with -3 100 trimming option. Unmapped reads and duplicates were filtered with samtools (v1.13). 

### Peak Calling
MACS3 (v3.0.0) was used to call peaks from the aligned ChIP-Seq data for each TF.

### Quality Assessment
Deeptools(v3.5.4) plotFingerprint option was used for enrichment estimation. The signal-to-noise ratios were calculated by PhantomPeakQualTools (version 1.2.2), and all the sample files passed the normalized strand cross-correlation coefficient (NSC ≥ 1.05) and relative strand cross-correlation coefficient (RSC ≥ 0.8). The correlations between replicates were evaluated by deeptools multiBamSummary option. Only the biological replicates with Pearson correlation coefficient ≥ 0.8 were retained for further analysis.

### Reproducibility Analysis and Annotation
IDR (version 2.0.3) was used to call reproducible peaks using 1% IDR as the threshold. Peak distribution was displayed with IGV (version 2.16.2) and annotated with ChIPseeker (version 1.38.0). 

## Results
1. **Peak Distribution**:
   - Two barplots visualizing the peak score distribution are included in the `results/` directory.

2. **Peak Overlap**:
   - The Upset plot of overlapping peaks among the five TFs are included in the `results/` directory.
3. **Peak score difference**:
   - The boxplots of peak value difference between unique and common peak regions are ncluded in the `results/` directory.
   - Higher peak scores were observed in overlapping regions compared to non-overlapping regions.

## Usage
### Prerequisites
Please install the following software to reproduce the analysis:
- FastQC
- Bowtie2
- Samtools
- MACS3
- Deeptools
- PhantomPeakQualTools
- IDR
- ChIPseeker

### Steps to Reproduce
Install all the prerequisites and follow step-by-step guide in scripts.

## Contributors
- [tang-sy](https://github.com/tang-sy) 

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
