#' Pick documentation matching some concepts or package names.
#'
#' These functions help you to reference the documentation of specific functions
#' across multiple packages. This is useful in meta-packages. * The functions
#' ending in `package` output all exported objects of the given packages, and
#' the functions ending in `concept` output all objects containing the given
#' concepts (strings passed to `@family`).
#' * The functions starting with `reference_` output a dataframe optimized for
#' building a reference table (maybe with `DT::datatable()` or
#' `knitr::kable()`).
#'
#' @param x A character vector giving concepts or package names to match.
#' @param url Character vector of length-1 giving a base url, e.g.
#'   "https://forestgeo.github.io/".
#' @param strip_s3class `TRUE` removes the class component of S3 methods.
#' @param packages A character vector with the names of packages to limit the
#'   search, or `NULL` to serach in all known libraries.
#'
#' @return A dataframe.
#'
#' @examples
#' \dontrun{
#' if (requireNamespace("fgeo.x", quietly = TRUE)) {
#'   library(fgeo.x)
#'
#'   reference_concept("datasets", url = "https://forestgeo.github.io/")
#'   reference_package("datasets", url = "https://forestgeo.github.io/")
#' }
#' }
#' @name reference_package
NULL
pick_docs <- function(package_or_concept) {
  force(package_or_concept)
  function(x, url = NULL, packages = NULL) {
    result <- pick_useful_docs(packages = packages) %>%
      filter(.[[package_or_concept]] %in% x)

    if (is.null(url)) {
      return(unique(result))
    }

    unique(link_topic(result, url))
  }
}

#' @rdname reference_package
#' @export
reference_package <- function(x,
                              url = NULL,
                              packages = NULL,
                              strip_s3class = TRUE) {
  out <- pick_docs("package")(x, url = url, packages = packages) %>%
    tidy_reference(strip_s3class)

  if (identical(nrow(out), 0L)) {
    warn(glue("No package matches '{x}'."))
  }

  out
}

#' @rdname reference_package
#' @export
reference_concept <- function(x,
                              url = NULL,
                              packages = NULL,
                              strip_s3class = TRUE) {
  out <- pick_docs("concept")(x, url = url, packages = packages) %>%
    tidy_reference(strip_s3class)

  if (identical(nrow(out), 0L)) {
    warn(glue("No concept matches '{x}'."))
  }

  out
}

tidy_reference <- function(.data, strip_s3class) {
  .data %>%
    collapse_alias(strip_s3class) %>%
    select(c("topic", "alias", "title")) %>%
    arrange(.data$alias)
}



#' Collapse the result of pick_docs() by alias.
#'
#' This avoids an unnecesary long result.
#'
#' @param .data The result of pick_docs().
#' @param strip_s3class `TRUE` strips the class component of S3 methods.
#'
#' @return A dataframe.
#' @noRd
collapse_alias <- function(.data, strip_s3class = FALSE) {
  .data %>%
    group_by(.data$topic) %>%
    mutate(
      alias = ifelse(
        strip_s3class,
        strip_or_not(.data$alias, .f = s3_strip_class),
        strip_or_not(.data$alias, .f = identity)
      )
    ) %>%
    ungroup() %>%
    unique()
}

strip_or_not <- function(x, .f = s3_strip_class) {
  paste(unique(.f(x)), collapse = ", ")
}

#' From the entire documentation dataframe, pick useful columns and rows.
#' @inheritParams reference_package
#' @return A dataframe.
#' @noRd
pick_useful_docs <- function(packages = NULL) {
  search_docs(packages = packages) %>%
    exclude_package_doc(packages) %>%
    exclude_internal_functions() %>%
    select(-.data$libpath, -.data$id, -.data$encoding, -.data$name) %>%
    unique()
}

exclude_package_doc <- function(.data, packages) {
  if (is.null(packages)) {
    return(.data)
  }

  .data %>%
    filter(!.data$alias %in% c(packages, glue("{package}-package")))
}

exclude_internal_functions <- function(.data) {
  .data %>%
    filter(!.data$keyword %in% "internal")
}

link_topic <- function(.data, url) {
  .data %>%
    mutate(
      topic   = glue("<a href={url}{package}/reference/{topic}>?</a>"),
      package = glue("<a href={url}{package}>{package}</a>")
    ) %>%
    arrange(.data$package)
}
