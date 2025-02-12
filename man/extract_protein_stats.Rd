% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/parse_mzTab.R
\name{extract_protein_stats}
\alias{extract_protein_stats}
\title{Extract protein statistics from mzTab}
\usage{
extract_protein_stats(
  mzt,
  contaminant_prefix = "CONTAMINANT_",
  output_file = NULL
)
}
\arguments{
\item{mzt}{Path to mzTab file}

\item{contaminant_prefix}{Prefix for contaminants, default is CONTAMINANT_}

\item{output_file}{Optional. Name of the output file}
}
\value{
Data frame with the following columns:
\itemize{
\item \code{protein_Id}: Protein accession.
\item \code{protein_coverage}: Coverage percentage of the protein sequence.
\item \code{opt_global_nr_found_peptides}: Number of peptidoforms for this protein. A peptide can be counted with multiple PTMs.
\item \code{PSMs}: Number of PSMs.
}
}
\description{
Extracts protein coverage, peptidoform count, and PSM count from an mzTab file.
}
