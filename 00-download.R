rm(list=ls())
# https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE174083
# https://ftp.ncbi.nlm.nih.gov/geo/series/GSE174nnn/GSE174083/suppl/
# https://www.biorxiv.org/content/10.1101/2021.05.18.444668v2.full
dir.create('data',showWarnings = FALSE)
geo <- GEOquery::getGEO(GEO = 'GSE174083')
study_metadata <- geo[[1]]@phenoData@data
save(study_metadata,file='data/study_metadata.RData')

raw_read_count <- 'https://ftp.ncbi.nlm.nih.gov/geo/series/GSE174nnn/GSE174083/suppl/GSE174083_RAW_READ_COUNTS.csv.gz'
download.file(
  url = raw_read_count,
  destfile = 'data/GSE174083_RAW_READ_COUNTS.csv.gz'
)
batch_corrected_file <- 'https://ftp.ncbi.nlm.nih.gov/geo/series/GSE174nnn/GSE174083/suppl/GSE174083_Normalized_READ_COUNTS_limma_batch_Corrected.csv.gz'
download.file(
  url = batch_corrected_file,
  destfile = 'data/GSE174083_Normalized_READ_COUNTS_limma_batch_Corrected.csv.gz'
)
cell_type_corrected <- 'https://ftp.ncbi.nlm.nih.gov/geo/series/GSE174nnn/GSE174083/suppl/GSE174083_Normalized_READ_COUNTS_limma_batch_cibersort_celltypes_Corrected.csv.gz'
download.file(
  cell_type_corrected,
  'data/GSE174083_Normalized_READ_COUNTS_limma_batch_cibersort_celltypes_Corrected.csv.gz'
)