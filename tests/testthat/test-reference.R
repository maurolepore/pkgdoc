test_that("adds a url", {
  out <- reference_package("base", url = "https://blah")$topic[[1]]
  expect_true(grepl("href", out))
  expect_true(grepl("blah", out))
})

test_that("warns if a package isn't attached", {
  reference_package("dplyr") |>
    expect_warning("should be attached")
})

test_that("errors if the package does not exist", {
  reference_package("badpackage") |>
    expect_error("badpackage") |>
    # Not ideal but also wans that the package isn't attached.
    expect_warning("should be attached")
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
  skip_if_not_installed("fgeo")
  withr::local_package("fgeo")

  result <- reference_package("fgeo")
  expect_s3_class(result, "data.frame")
  expect_named(result, c("topic", "alias", "title", "concept", "package"))

  expect_false(grepl("href", result$topic[[1]]))
})

test_that("no longer includes package documentation", {
  skip_if_not_installed("fgeo")
  withr::local_package("fgeo")

  expect_false(any(grepl("fgeo-package", unique(reference_package("fgeo")$alias))))
})

test_that("reference_concept() errors if some concept is not matched", {
  expect_error(
    reference_concept(c("combine strings", "bad concept")),
    "No concept matches.*bad concept"
  )
})

test_that("reference_concept() is sensitive to `concept`", {
  out <- reference_concept("combine strings", packages = "base")
  expect_equal(unique(out$topic), "paste")
})

test_that("reference_concept() is sensitive to `packages`", {
  out <- reference_concept("combine strings", packages = "base")
  expect_equal(unique(out$package), "base")
})
