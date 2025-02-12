% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/parse_msstats_in.R
\name{strip_ptms_from_msstats_in}
\alias{strip_ptms_from_msstats_in}
\title{Preprocess msstats_in by removing contaminants and stripping PTMs from peptide sequence for function extract_peptides_per_protein}
\usage{
strip_ptms_from_msstats_in(
  msstats_input_path,
  contaminant_prefix = "CONTAMINANT"
)
}
\arguments{
\item{msstats_input_path}{Path to msstats input style file from quantms (probably works for other programs as well?)}

\item{contaminant_prefix}{Prefix for contaminants (default is CONTAMINANT)}
}
\value{
Data frame without contaminants and with column PeptideSequence stripped from PTMs
}
\description{
Preprocess msstats_in by removing contaminants and stripping PTMs from peptide sequence for function extract_peptides_per_protein
}
