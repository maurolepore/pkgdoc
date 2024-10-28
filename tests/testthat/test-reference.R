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
