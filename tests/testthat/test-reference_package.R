

context("reference_concept")

test_that("reference_concept fails gracefully w/ inexisting concept", {
  expect_warning(
    reference_concept("bad concept"),
    "No concept matches.*bad concept"
  )
})

test_that("reference_concept picks one topic & is sensitive to `packages`", {
  expect_equal(
    reference_concept("combine strings", packages = "base")$topic,
    "paste"
  )
})

test_that("reference_package adds a url", {
  skip_if_not_installed("base")

  expect_true(
    grepl("href", reference_package("base", url = "https://...")$topic[[1]])
  )
})



context("reference_package")

test_that("reference_package fails gracefully w/ inexisting concept", {
  expect_warning(
    reference_package("badpackage"),
    "No package matches.*badpackage"
  )
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

test_that("reference_package with fgeo outputs the expected data structure", {
  skip_if_not_installed("fgeo")

  result <- reference_package("fgeo")
  expect_is(result, "data.frame")
  expect_named(result, c("topic", "alias", "title"))

  # Compare next test
  expect_false(grepl("href", result$topic[[1]]))
})

test_that("reference_package no longer includes package documentation", {
  skip_if_not_installed("fgeo")
  expect_false(any(grepl("fgeo-package", unique(reference_package("fgeo")$alias))))
})
