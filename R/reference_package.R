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
#' @family retrieve documentation
NULL
reference_any <- function(doc) {
  force(doc)
  function(x, url = NULL, packages = NULL, strip_s3class = TRUE) {
    warn_unnattached(x, doc)
    pick <- pick_doc(packages = packages, doc = doc, x = x)

    result <- tidy_reference(may_url(pick, url), strip_s3class)
    result
  }
}

#' @rdname reference_package
#' @export
reference_package <- reference_any("package")

#' @rdname reference_package
#' @export
reference_concept <- reference_any("concept")



# TODO relocate -----------------------------------------------------------

pick_useful_doc <- function(packages = NULL) {
  search_docs(packages = packages) %>%
    exclude_package_doc(packages) %>%
    exclude_internal_functions() %>%
    select(-.data$libpath, -.data$id, -.data$encoding, -.data$name) %>%
    unique()
}

link_topic <- function(.data, url) {
  .data %>%
    mutate(
      topic   = glue("<a href={url}{package}/reference/{topic}>?</a>"),
      package = glue("<a href={url}{package}>{package}</a>")
    ) %>%
    arrange(.data$package)
}

may_url <- function(x, url) {
  if (is.null(url)) {
    return(unique(x))
  }
  unique(link_topic(x, url))
}









# Helpers -----------------------------------------------------------------

warn_unnattached <- function(x, doc) {
  if (!identical(doc, "package")) {
    return(invisible(x))
  }

  if (!all(attached(x))) {
    unnatacched <- x[!attached(x)]
    warn(glue("
      All packages should be attached `strip_s3class` to work properly.
      Not attached: {unnatacched}
    "))
  }
}

pick_doc <- function(packages, doc, x) {
  result <- search_docs(packages = packages) %>%
    exclude_package_doc(packages) %>%
    exclude_internal_functions() %>%
    select(-.data$libpath, -.data$id, -.data$encoding, -.data$name) %>%
    unique() %>%
    filter(.[[doc]] %in% x)

  may_warn_missing_doc(result, doc, x)
  result
}

tidy_reference <- function(.data, strip_s3class) {
  .data %>%
    collapse_alias(strip_s3class) %>%
    select(c("topic", "alias", "title", "concept", "package")) %>%
    arrange(.data$alias)
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

attached <- function(x) {
  purrr::map_lgl(glue("package:{x}"), rlang::is_attached)
}

may_warn_missing_doc <- function(.data, doc, x) {
  good_request <- x %in% unique(.data[[doc]])
  if (all(good_request))
    return(invisible(.data))

  bad_request <- x[!good_request]
  warn(glue("No {doc} matches '{bad_request}'."))
}

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

