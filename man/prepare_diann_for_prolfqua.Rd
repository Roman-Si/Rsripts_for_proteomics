% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/parse_diann.R
\name{prepare_diann_for_prolfqua}
\alias{prepare_diann_for_prolfqua}
\title{Prepare diann dataframe for prolfqua}
\usage{
prepare_diann_for_prolfqua(
  diann_dataframe,
  qvalue = 0.01,
  response_level = "protein"
)
}
\arguments{
\item{diann_dataframe}{The diann dataframe, prefiltered with filter_diann_parquet}

\item{qvalue}{FDR for response level (default 0.01)}

\item{response_level}{Specifies the level to use:
\itemize{
\item \code{"protein"} (default): Will use the proteinGroup level MaxLFQ
\item \code{"gene"}: Will use the gene level MaxLFQ
}}
}
\value{
Data frame with reliable precursors and without contaminants and the following columns for msstats_input format
}
\description{
Converts the diann dataframe to a protein-level dataframe that will be converted to prolfqua object with create_lfqdata function
}
