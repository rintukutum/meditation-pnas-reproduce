rm(list=ls())
raw_rc <- readr::read_csv(
  'data/GSE174083_RAW_READ_COUNTS.csv.gz',
  col_names = TRUE
)
raw_count <- data.frame(raw_rc[,-1])
rownames(raw_count) <- as.character(unlist(raw_rc[,1]))
load('data/study_metadata.RData')

get_descrpID <- function(x){
  xout <- strsplit(x,split='_R1_')[[1]][1]
  xout <- gsub('^X','',xout)
  xout <- gsub('\\_T','\\-T',xout)
  return(xout)
}
colNames <- as.character(
  sapply(colnames(raw_count),
         get_descrpID)
)
#### QC
# setdiff(colNames,study_metadata$description)
# setdiff(study_metadata$description,colNames)
rownames(study_metadata) <- study_metadata$description
geo_ids <- study_metadata[colNames,'geo_accession']
study_metadata <- study_metadata[colNames,]
rownames(study_metadata) <- geo_ids
colnames(raw_count) <- geo_ids
idx_control <- grep('ERCC',rownames(raw_count))
#----
# log transformed
library('DESeq2')
timepoint <- sapply(
  study_metadata[,'treatment:ch1'],
  function(x){
    strsplit(x,split=' ')[[1]][1]
  })
phenotype <- data.frame(
  treatment = factor(timepoint)
)
dds <- DESeqDataSetFromMatrix(
  countData = raw_count,
  colData = phenotype,
  design = ~ treatment
)
vsd <- varianceStabilizingTransformation(dds)