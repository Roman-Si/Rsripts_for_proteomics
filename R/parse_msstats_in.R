#' @import dplyr
#' @importFrom stringr str_replace_all str_locate
#' @importFrom Biostrings readAAStringSet
#' @importFrom cleaver cleave
NULL


#' Preprocess msstats_in by removing contaminants and stripping PTMs from peptide sequence for function extract_peptides_per_protein
#'
#' @param msstats_input_path Path to msstats input style file from quantms (probably works for other programs as well?)
#' @param contaminant_prefix Prefix for contaminants (default is CONTAMINANT)
#' @return Data frame without contaminants and with column PeptideSequence stripped from PTMs
#' @export
strip_ptms_from_msstats_in <- function(msstats_input_path, contaminant_prefix = "CONTAMINANT") {
    msstats_in_df <- read.csv(msstats_input_path, header = TRUE, sep = ',')
    msstats_in_df <- msstats_in_df %>%
      filter(!grepl(contaminant_prefix, ProteinName)) %>%
      mutate(PeptideSequence = stringr::str_replace_all(PeptideSequence, "\\(.*?\\)", "") %>% # Remove modifications
               stringr::str_replace_all("\\.", "")) # Remove dots
    return(msstats_in_df)
}



#' Extract peptide sequences, count and indices per protein
#'
#' Processes the msstats_in_df dataframe to extract peptide sequences, number and indexes of quantified peptides for each protein. Trypsin cutting before proline.
#'
#' @param msstats_in_df msstats_input style dataframe with PeptideSequence column stripped from PTMs and proteinId in column ProteinName
#' @param fasta_path Path to fasta file with protein sequences (can be gzipped)
#' @param delimiter Delimiter for peptides shared between different proteins (default is ;)
#' @param uniprot_fasta_header If FASTA headers are in UniProt format parses the accession (deafult FALSE)
#' @param missed_cleavages Allow n missed trypsin cleavages (deafult 2)
#' @param min_pep_len Min theoretical tryptic peptide length (default 7)
#' @param max_pep_len Max theoretical tryptic peptide length (default 40, for dia-nn change to 30)

#' @return Data frame with peptide info (without PTMs) for each detected protein including:
# - `peptide_seqs`: ; delimited peptide sequences
# - `nr_theoretical_tryptic_peptides`: count of theoretical tryptic peptides
# - `nr_unmodified_peptides`: count of unmodified peptides
# - `peptide_index`: min and max index of identified peptides in protein sequence, useful to check which part of the protein is detected
#' @details This function performs the following steps:
#'   - Filters the FASTA file to include only detected proteins from msstats_in_df
#'   - Extracts peptide sequences, counts, and positional indices for each protein.
#' @export
extract_peptides_per_protein <- function(msstats_in_df, fasta_path, delimiter = ";", uniprot_fasta_header = FALSE, missed_cleavages = 2, min_pep_len = 7, max_pep_len = 40) {  
  
  # Read and preprocess inputs
  protein_ids <- unlist(strsplit(msstats_in_df$ProteinName, delimiter)) %>% unique()
  fasta_file <- filter_fasta_file_with_ids(fasta_path, protein_ids, uniprot_fasta_header = uniprot_fasta_header)

  # Initialize peptide_df
  peptide_df <- data.frame(protein_Id = protein_ids, nr_theoretical_tryptic_peptides = NA, nr_unmodified_peptides = NA,  peptide_index = NA, peptide_seqs = NA, stringsAsFactors = FALSE)

  # Iterate over proteins in fasta
  for (i in seq_along(fasta_file)) {
    protein_id <- names(fasta_file)[i]
    protein_seq <- as.character(fasta_file[[i]])
    start_index <- NA
    end_index <- NA

    # Get number of theoretical tryptic peptides
    in_silico_peptides <- cleave(protein_seq, "trypsin-simple", missedCleavages = 0:missed_cleavages) %>%
      unlist() %>% as.character() %>%
      .[nchar(.) >= min_pep_len & nchar(.) <= max_pep_len]

    peptides <- msstats_in_df %>%
      filter(grepl(protein_id, ProteinName)) %>%
      pull(PeptideSequence) %>%
      unique()
    

    # Find peptide indices
    for (pep in peptides) {
      pep_indices <- stringr::str_locate(protein_seq, pep)
      start_index <- min(start_index, pep_indices[1], na.rm = TRUE)
      end_index <- max(end_index, pep_indices[2], na.rm = TRUE)
      }

    # Update peptide_df
    peptide_df[peptide_df$protein_Id == protein_id, ] <- list(
      protein_Id = protein_id,
      nr_theoretical_tryptic_peptides = length(in_silico_peptides),
      nr_unmodified_peptides = length(peptides),
      peptide_index = paste0(start_index, "-", end_index),
      peptide_seqs = paste(peptides, collapse = delimiter)
      
    )
  }
  
  return(peptide_df)
}