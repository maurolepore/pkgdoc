#' Pick documentation matching some concepts or package names.
#'
#' These functions help you to reference the documentation of specific functions
#' across multiple packages. This is useful in meta-packages.
#'
#' @param x A character vector giving concepts or package names to match.
#' @param cols Character vector giving the name of columns to select from the
#'   result, e.g.  c("alias", "topic", "title").
#' @param url Character vector of length-1 giving a base url, e.g.
#'   "https://forestgeo.github.io/".
#'
#' @return A dataframe.
#'
#' @examples
#' pick_fgeo_concept("datasets")
#' pick_fgeo_package("fgeo.x")
#'
#' @name pick_fgeo_concept
NULL

pick_docs <- function(column_name) {
  force(column_name)
  function(x, cols = NULL, url = "https://forestgeo.github.io/") {
    search_help() %>%
      filter(.[[column_name]] %in% x) %>%
      collapse_alias() %>%
      link_topic(url) %>%
      select(cols %||% names(.)) %>%
      unique()
  }
}

#' @rdname pick_fgeo_concept
#' @export
pick_package <- pick_docs("package")

#' @rdname pick_fgeo_concept
#' @export
pick_concept <- pick_docs("concept")

pick_fgeo_doc <- function(.f) {
  function(x) {
    .f(x,
      cols = c("alias", "topic", "title"),
      url = "https://forestgeo.github.io/"
    ) %>%
      group_by(.data$title) %>%
      mutate(
        alias = paste(unique(strip_s3class(.data$alias)), collapse = ", ")
      ) %>%
      ungroup() %>%
      select(.data$topic, .data$alias, .data$title) %>%
      unique()
  }
}

#' @rdname pick_fgeo_concept
#' @export
pick_fgeo_concept <- pick_fgeo_doc(pick_concept)

#' @rdname pick_fgeo_concept
#' @export
pick_fgeo_package <- pick_fgeo_doc(pick_package)

# Adapted from utils::isS3method()
strip_s3class <- function(x) {
  unlist(lapply(x, strip_s3class_impl))
}

strip_s3class_impl <- function(x) {
  if (!utils::isS3method(x)) {
    return(x)
  }

  f.c <- strsplit(x, ".", fixed = TRUE)[[1]]
  nfc <- length(f.c)

  if (nfc == 2) {
    return(f.c[[1L]])
  }

  ok <- logical(nfc)
  for (j in 2:nfc) {
    ok[[j]] <- utils::isS3method(
      f = paste(f.c[1:(j - 1)], collapse = "."),
      class = paste(f.c[j:nfc], collapse = ".")
    )
  }

  .f <- character(nfc)
  for (j in 2:nfc) {
    .f[[j]] <- paste(f.c[1:(j - 1)], collapse = ".")
  }

  .f[[which(ok)]]
}



#' Explore the documentation of __fgeo__.
#'
#' @param pattern Character string of length one to match an entry in packages
#'   documentation.
#' @param ... Bare names of the columns to select. Valid names are `package`,
#'   `name`, `title`, `topic`, `type`, `alias`, `keyword`, `concept`. If no name
#'   is given, then all names are returned.
#' @param packages A character vector with the names of packages to search
#'   through, or NULL in which case all available packages in the library trees
#'   specified by lib.loc are searched. Defaults to search only the core
#'   packages of __fgeo__.
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
  result <- search_docs(packages)
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

search_docs <- function(packages) {
  # FIXME
  these_packages <- packages %||% fgeo:::fgeo_packages()
  # Surprisingly all packages that match are included
  docs <- utils::hsearch_db(package = these_packages)
  docs <- suppressMessages(purrr::reduce(docs, dplyr::full_join))
  docs %>%
    tibble::as.tibble() %>%
    purrr::set_names(tolower) %>%
    filter(.data$package %in% these_packages) %>%
    exclude_package_doc(packages) %>%
    select(-.data$libpath, -.data$id, -.data$encoding, -.data$name) %>%
    unique()
}

exclude_package_doc <- function(.data, package) {
  .data %>%
    filter(!.data$alias %in% c(package, glue("{package}-package")))
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
    dplyr::filter_all(dplyr::any_vars(grepl(pattern, .)))
}

collapse_alias <- function(.data) {
  .data %>%
    group_by(.data$topic) %>%
    mutate(name = paste0(unique(.data$alias), collapse = ", ")) %>%
    ungroup()
}

link_topic <- function(.data, url) {
  .data %>%
    mutate(
      topic   = glue("<a href={url}{package}/reference/{topic}>?</a>"),
      package = glue("<a href={url}{package}>{package}</a>")
    ) %>%
    arrange(.data$package)
}
