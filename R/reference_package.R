#' Create a data.frame with documentation metadata of one or more packages
#'
#' Create a data.frame with documentation metadata of one or more packages. If
#' you develop a universe, such as the tidyverse or tidymodels, pkgdoc helps you
#' to easily create a universe-wide reference for the pkgdown website of your
#' meta-package.
#'
#' @param x A character vector giving concepts or package names to match.
#' @param url Character vector of length-1 giving a base url, e.g.
#'   "https://maurolepore.github.io/".
#' @param strip_s3class `TRUE` removes the class component of S3 methods.
#' @param packages A character vector with the names of packages to limit the
#'   search, or `NULL` to serach in all known libraries.
#'
#' @return A dataframe.
#'
#' @examples
#' reference_package("datasets")
#'
#' @name reference_package
#' @family retrieve documentation
NULL

reference_any <- function(doc) {
  force(doc)
  function(x, url = NULL, packages = NULL, strip_s3class = TRUE) {
    warn_unnattached(x, doc)
    pick <- pick_doc(packages = packages, doc = doc, x = x)

    result <- tidy_reference(may_add_url(pick, url), strip_s3class)
    result
  }
}
#' @rdname reference_package
#' @export
reference_package <- reference_any("package")

#' @rdname reference_concept
#' @export
reference_concept <- reference_any("concept")

warn_unnattached <- function(x, doc) {
  if (!identical(doc, "package")) {
    return(invisible(x))
  }

  if (!all(attached(x))) {
    unnatacched <- x[!attached(x)]
    warn(glue("
      All packages should be attached to work properly.
      Not attached: {unnatacched}
    "))
  }
}

pick_doc <- function(packages, doc, x) {
  result <- search_docs(packages = packages) %>%
    exclude_package_doc(packages) %>%
    exclude_internal_functions() %>%
    select(-"libpath", -"id", -"encoding", -"name") %>%
    unique() %>%
    filter(.[[doc]] %in% x)

  abort_missing_doc(result, doc, x)
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

abort_missing_doc <- function(.data, doc, x) {
  good_request <- x %in% unique(.data[[doc]])
  if (all(good_request)) {
    return(invisible(.data))
  }

  bad_request <- x[!good_request]
  abort(glue("No {doc} matches '{bad_request}'."))
}

collapse_alias <- function(.data, strip_s3class = FALSE) {
  .data %>%
    group_by(.data$topic) %>%
    mutate(
      alias = dplyr::case_when(
        !strip_s3class ~ may_strip_s3class(.data$alias, .f = identity),
        strip_s3class ~ may_strip_s3class(.data$alias, .f = s3_strip_class),
      )
    ) %>%
    ungroup() %>%
    unique()
}

may_strip_s3class <- function(x, .f = s3_strip_class) {
  paste(unique(.f(x)), collapse = ", ")
}

may_add_url <- function(x, url) {
  if (is.null(url)) {
    return(unique(x))
  }
  unique(link_topic(x, url))
}

link_topic <- function(.data, url) {
  .data %>%
    mutate(
      topic   = glue("<a href={url}{package}/reference/{topic}>?</a>"),
      package = glue("<a href={url}{package}>{package}</a>")
    ) %>%
    arrange(.data$package)
}
