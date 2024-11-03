test_that("errors if the package does not exist", {
  expect_error(reference_package("bad"), "bad") |>
    # Not ideal but also wans that the package isn't attached.
    expect_warning("should be attached")
})

test_that("yields the expected data.frame", {
  out <- reference_package(c("datasets"))

  expect_s3_class(out, "data.frame")
  expect_named(out, c("topic", "alias", "title", "concept", "package"))
  are_type <- unlist(unique(lapply(out, typeof)))
  expect_equal(are_type, "character")
})

test_that("works with multiple packages", {
  out <- reference_package(c("datasets", "grDevices"))
  expect_equal(unique(out$package), c("datasets", "grDevices"))
})

test_that("warns if a package isn't attached", {
  packages <- c("tools", "datasets")
  expect_warning(reference_package(packages), "Not attached.*tools")
})

test_that("with no url creates no link", {
  out <- reference_package("datasets")$topic[[1]]
  expect_false(grepl("href", out))
})

test_that("with a url creates a link", {
  out <- reference_package("datasets", url = "https://blah")$topic[[1]]
  expect_true(grepl("href", out))
})

test_that("by default srips teh class of S3 methods", {
  out <- reference_package("base")
  alias <- unique(out[grepl("all.equal", out$alias), "alias"])[[1]]
  expect_false(grepl("numeric", alias))

  out <- reference_package("base", strip_s3class = FALSE)
  alias <- unique(out[grepl("all.equal", out$alias), "alias"])[[1]]
  expect_true(grepl("numeric", alias))
})

test_that("doesn't include the package-level documentation", {
  out <- reference_package("pkgdoc")
  expect_false(any(grepl("pkgdoc-package", unique(out$alias))))
})

test_that("takes a `url_template`", {
  url_template <- "https://maurolepore.github.io/{package}/reference/{topic}.html"
  out <- reference_package("pkgdoc", url_template = url_template)
  expect_true(grepl("pkgdoc", out$topic[[1]]))
})

test_that("with bad `url_template` errors gracefully", {
  bad <- "https://{bad}/{topic}.html"
  expect_error(reference_package("pkgdoc", url_template = bad), "not found")
})
