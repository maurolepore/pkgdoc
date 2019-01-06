#' Dataframe the documentation of installed packages.
#'
#' This is fundamentally a dataframe version of the output of
#' [utils::hsearch_db()].
#'
#' @inheritParams reference_package
#'
#' @return A dataframe.
#'
#' @examples
#' search_docs(NULL)
#'
#' @export
#' @family retrieve documentation
search_docs <- function(packages = NULL) {
  docs <- suppressMessages(
    purrr::reduce(utils::hsearch_db(), dplyr::full_join)
  )

  result <- set_names(tibble::as.tibble(docs), tolower)

  if (is.null(packages)) {
    return(result)
  }

  filter(result, .data$package %in% packages)
}
