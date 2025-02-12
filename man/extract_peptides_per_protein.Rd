% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/parse_msstats_in.R
\name{extract_peptides_per_protein}
\alias{extract_peptides_per_protein}
\title{Extract peptide sequences, count and indices per protein}
\usage{
extract_peptides_per_protein(
  msstats_in_df,
  fasta_path,
  delimiter = ";",
  uniprot_fasta_header = FALSE,
  missed_cleavages = 2,
  min_pep_len = 7,
  max_pep_len = 40
)
}
\arguments{
\item{msstats_in_df}{msstats_input style dataframe with PeptideSequence column stripped from PTMs and proteinId in column ProteinName}

\item{fasta_path}{Path to fasta file with protein sequences (can be gzipped)}

\item{delimiter}{Delimiter for peptides shared between different proteins (default is ;)}

\item{uniprot_fasta_header}{If FASTA headers are in UniProt format parses the accession (deafult FALSE)}

\item{missed_cleavages}{Allow n missed trypsin cleavages (deafult 2)}

\item{min_pep_len}{Min theoretical tryptic peptide length (default 7)}

\item{max_pep_len}{Max theoretical tryptic peptide length (default 40, for dia-nn change to 30)}
}
\value{
Data frame with peptide info (without PTMs) for each detected protein including:
}
\description{
Processes the msstats_in_df dataframe to extract peptide sequences, number and indexes of quantified peptides for each protein. Trypsin cutting before proline.
}
\details{
This function performs the following steps:
\itemize{
\item Filters the FASTA file to include only detected proteins from msstats_in_df
\item Extracts peptide sequences, counts, and positional indices for each protein.
}
}
