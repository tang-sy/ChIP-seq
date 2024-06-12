library(usethis)
library(devtools)
library(org.Zmays.eg.db)

library(ChIPseeker)
library(GenomicRanges)
library(GenomicFeatures)
library(dplyr)


bed_folder <- "result/peaks/"     # Define folder containing all bed files
gff_file <- "result/ZmB73.gff3"   # Define location of annotation file


# Create TxDb object from a GFF/GTF file
txdb <- makeTxDbFromGFF(gff_file, format = "gff3")


# Create list to store annotation
peaksAnno <- list()  # Store Annotation information
peaksGR <- list()   # Store GRanges objects

# Get a list of all BED files in the directory
bed_files <- list.files(bed_folder, pattern = "\\.bed$", full.names = TRUE)

# Loop through all BED files and generate annotations 
for (bed_file in bed_files) {
        name <- substring(basename(bed_file),1,nchar(basename(bed_file))-8)
        peaks <- read.table(bed_file, header = FALSE, stringsAsFactors = FALSE)

    # Output genes located near the peaks
    df <- getPeaks(bed_file,txdb)
    write.csv(df, paste0(name, ".csv"), row.names = FALSE, quote = FALSE)
    
    # Create GRanges object
        peaks <- GRanges(
                seqnames = peaks[, 1],
                ranges = IRanges(start = as.numeric(peaks[, 2]),
                                 end = as.numeric(peaks[, 3])),
                name = peaks[, 4],
                score = as.numeric(peaks[, 5])
        )
        peaksGR[[name]] <- peaks
        peakAnno <- annotatePeak(peaks, tssRegion=c(-3000,3000),TxDb=txdb)
        peaksAnno[[name]] <- peakAnno
        
}

# plot
plotAnnoBar(peaksAnno, title: "Feature distribution")
plotDistToTSS(peaksAnno, title="Distribution of transcription factor-binding loci relative to TSS")

