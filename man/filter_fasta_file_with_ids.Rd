% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/generic_functions.R
\name{filter_fasta_file_with_ids}
\alias{filter_fasta_file_with_ids}
\title{Filter FASTA with IDs}
\usage{
filter_fasta_file_with_ids(
  fasta_path,
  protein_ids,
  uniprot_fasta_header = FALSE
)
}
\arguments{
\item{fasta_path}{Path to the FASTA file}

\item{protein_ids}{A vector with the IDs to keep}

\item{uniprot_fasta_header}{If FASTA headers are in UniProt format parses the accession (deafult FALSE)}
}
\value{
The filtered Biostrings XStringSet object
}
\description{
Filter a FASTA file for proteins present in a vector
}
