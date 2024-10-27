test_that("adds a url", {
  out <- reference_package("base", url = "https://blah")$topic[[1]]
  expect_true(grepl("href", out))
  expect_true(grepl("blah", out))
})

test_that("warns if some package isn't attached", {
  reference_package("dplyr") |>
    expect_warning("should be attached")
})

test_that("errors if the package does not exist", {
  reference_package("badpackage") |>
    expect_error("badpackage")
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

test_that("with fgeo outputs the expected data structure", {
  skip_if_not_installed("MASS")
  skip_if_not_installed("fgeo")
  library("fgeo")

  result <- reference_package("fgeo")
  expect_s3_class(result, "data.frame")
  expect_named(result, c("topic", "alias", "title", "concept", "package"))

  # Compare next test
  expect_false(grepl("href", result$topic[[1]]))
})

test_that("no longer includes package documentation", {
  skip_if_not_installed("MASS")
  skip_if_not_installed("fgeo")
  library("fgeo")

  expect_false(any(grepl("fgeo-package", unique(reference_package("fgeo")$alias))))
})
