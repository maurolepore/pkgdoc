pick_docs <- function(package_or_concept) {
  force(package_or_concept)
  function(x, url = NULL, packages = NULL) {
    result <- search_help(packages = packages) %>%
      filter(.[[package_or_concept]] %in% x)

    if (is.null(url)) {
      return(unique(result))
    }

    unique(link_topic(result, url))
  }
}



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
#' pick_package("base")
#'
#' pick_concept("PCA")
#'
#' packages <- c("stats", "MASS")
#' pick_package(packages)
#'
#' concepts <- c("combine strings", "files", "PCA")
#' pick_concept(concepts)
#'
#' \dontrun{
#' if (requireNamespace("fgeo.x", quietly = TRUE)) {
#'   library(fgeo.x)
#'
#'   reference_concept("datasets", url = "https://forestgeo.github.io/")
#'   reference_package("datasets", url = "https://forestgeo.github.io/")
#' }
#' }
#' @export
pick_package <- pick_docs("package")

#' @rdname pick_package
#' @export
pick_concept <- pick_docs("concept")

#' @rdname pick_package
#' @export
reference_package <- function(x,
                              url = NULL,
                              packages = NULL,
                              strip_s3class = TRUE) {
  pick_package(x, url = url, packages = packages) %>%
    collapse_alias(strip_s3class = strip_s3class) %>%
    select(c("topic", "alias", "title"))
}

#' @rdname pick_package
#' @export
reference_concept <- function(x,
                              url = NULL,
                              packages = NULL,
                              strip_s3class = TRUE) {
  pick_concept(x, url = url, packages = packages) %>%
    collapse_alias(strip_s3class) %>%
    select(c("topic", "alias", "title"))
}



#' Dataframe the documentation of installed packages.
#'
#' This is fundamentally a dataframe version of the output of
#' [utils::hsearch_db()].
#'
#' @inheritParams pick_package
#'
#' @return A dataframe.
#'
#' @examples
#' search_docs(NULL)
#'
#' @export
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



#' Flatten the result of pick_package() and pick_concept() by alias.
#'
#' @param .data The result of pick_package() and pick_concept().
#' @param strip_s3class `TRUE` strips the class component of S3 methods.
#'
#' @return A dataframe.
#'
#' @examples
#' \dontrun{
#' collapse_alias(pick_package("fgeo"))
#' collapse_alias(pick_package("fgeo"), strip_s3class = TRUE)
#' }
#'
#' @noRd
collapse_alias <- function(.data, strip_s3class = FALSE) {
  strip <- function(x) {
    paste(unique(s3_strip_class(x)), collapse = ", ")
  }
  asis <- function(x) {
    paste0(unique(x), collapse = ", ")
  }

  .data %>%
    group_by(.data$topic) %>%
    mutate(
      alias = ifelse(strip_s3class, strip(.data$alias), asis(.data$alias))
    ) %>%
    ungroup() %>%
    unique()
}



#' Explore the documentation of __fgeo__.
#'
#' @param pattern Character string of length one to match an entry in packages
#'   documentation.
#' @param ... Bare names of the columns to select. Valid names are `package`,
#'   `name`, `title`, `topic`, `type`, `alias`, `keyword`, `concept`. If no name
#'   is given, then all names are returned.
#' @inheritParams pick_package
#'
#' @return A dataframe.
#'
#' @examples
#' # Filter rows with a matching pattern.
#' search_help("abundance")
#'
#' # Select specific columns
#' search_help("abundance", concept, topic, title)
#'
#' # Exclude specific columns
#' search_help("abundance", -package)
#'
#' @family functions for developers
#' @noRd
search_help <- function(pattern = NULL,
                        ...,
                        packages = NULL,
                        exclude_internal = TRUE) {
  result <- search_docs(packages = packages) %>%
    exclude_package_doc(packages) %>%
    select(-.data$libpath, -.data$id, -.data$encoding, -.data$name) %>%
    unique()

  if (exclude_internal) {
    result <- exclude_internal_functions(result)
  }

  if (want_specific_cols(enquos(...))) {
    result <- select_these_cols(result, enquos(...))
  }

  if (!is.null(pattern)) {
    result <- pick_this_pattern(result, pattern)
  }

  unique(result)
}

exclude_package_doc <- function(.data, packages) {
  if (is.null(packages)) {
    return(.data)
  }

  .data %>%
    filter(!.data$alias %in% c(packages, glue("{package}-package")))
}

want_specific_cols <- function(elipsis) {
  any(purrr::map_lgl(elipsis, rlang::is_quosure))
}

exclude_internal_functions <- function(.data) {
  .data %>%
    filter(!.data$keyword %in% "internal")
}

select_these_cols <- function(.data, elipsis) {
  .data %>%
    select(!!! elipsis)
}

pick_this_pattern <- function(.data, pattern) {
  .data %>%
    dplyr::filter_all(dplyr::any_vars(grepl(pipes(pattern), .)))
}

pipes <- function(x) {
  paste(x, collapse = "|")
}

link_topic <- function(.data, url) {
  .data %>%
    mutate(
      topic   = glue("<a href={url}{package}/reference/{topic}>?</a>"),
      package = glue("<a href={url}{package}>{package}</a>")
    ) %>%
    arrange(.data$package)
}
