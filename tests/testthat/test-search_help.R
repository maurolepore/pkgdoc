context("reference_package")

test_that("with fgeo outputs the expected data structure", {
  skip_if_not_installed("fgeo")

  result <- reference_package("fgeo")
  expect_is(result, "data.frame")
  expect_named(result, c("topic", "alias", "title"))

  # Compare next test
  expect_false(grepl("href", result$topic[[1]]))
})
test_that("with fgeo is sensitive adds a url", {
  skip_if_not_installed("fgeo")

  expect_true(
    grepl("href", reference_package("fgeo", url = "https://...")$topic[[1]])
  )
})

test_that("works with base", {
  expect_is(reference_package("base"), "data.frame")
})

test_that("is sensitive to strip_s3class", {
  pull_all_equal <- function(x) {
    x %>%
      dplyr::filter(topic == "all.equal") %>%
      dplyr::distinct() %>%
      dplyr::pull(alias) %>%
      strsplit(", ") %>%
      unlist()
  }

  strip_false <- reference_package("base", strip_s3class = FALSE) %>%
    pull_all_equal()
  expect_true("all.equal.character" %in% strip_false)

  strip_true <- reference_package("base", strip_s3class = TRUE) %>%
    pull_all_equal()
  expect_false("all.equal.character" %in% strip_true)
})

test_that("picks expected topic and is sensitive to `packages`", {
  expect_equal(
    reference_concept("combine strings", packages = "base")$topic,
    "paste"
  )
  expect_equal(
    reference_concept("combine strings", packages = "not_a_package")$alias,
    character(0)
  )
})

test_that("no longer includes package documentation", {
  skip_if_not_installed("fgeo")
  expect_false(any(grepl("fgeo-package", unique(reference_package("fgeo")$alias))))
})

test_that("no longer misses fgeo_elevation", {
  skip_if_not_installed("fgeo.tool")
  expect_true(any(grepl("fgeo_elevation", reference_package("fgeo.tool")$alias)))
})

test_that("no longer picks demography_impl", {
  skip_if_not_installed("fgeo.analyze")
  skip_if_not_installed("fgeo")

  strip_false <- reference_concept(
    "demography functions",
    url = NULL,
    packages = fgeo:::fgeo_packages()
  )$topic

  expect_false(any(grepl("demography_impl", strip_false)))
  expect_true(any(grepl("demography_ctfs", strip_false)))
})



context("search_docs")

test_that("returns the expected data structure", {
  cols <- c(
    "package",
    "libpath",
    "id",
    "name",
    "title",
    "topic",
    "encoding",
    "type",
    "alias",
    "keyword",
    "concept"
  )
  expect_named(
    result <- search_docs(), cols
  )
  expect_true(length(unique(result$package)) > 1)
  expect_is(result, "tbl")
})

test_that("can pick specific packages", {
  expect_length(unique(search_docs(c("base", "utils"))$package), 2)
})
