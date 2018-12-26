context("search_help")

test_that("with no arguments returns all columns", {
  cols <- c(
    "package", "title", "topic", "type", "alias", "keyword", "concept"
  )
  expect_named(search_help(), cols)
  expect_is(search_help(), "tbl")
})

test_that("with one column name returns only that colum", {
  cols <- c("package")
  expect_named(search_help(NULL, package), cols)
})

test_that("excludes columns", {
  cols <- c("topic", "type", "alias", "keyword", "concept")
  expect_named(search_help(NULL, -package, -title), cols)
})

test_that("with a pattern returns that pattern", {
  expect_equal(
    unique(search_help("combine strings", packages = "base")$concept),
    "combine strings"
  )
})

test_that("is sensitive to argument `packages`", {
  expect_equal(
    unique(search_help(packages = c("base", "utils"))$package),
    c("base", "utils")
  )
})

test_that("errs with infomative error messages", {
  expect_error(search_help(NULL, invalid), "object.*not found")
  expect_error(search_help(invalid), "object.*not found")
})



context("pick_package")

test_that("no longer misses fgeo_elevation", {
  skip_if_not_installed("fgeo.tool")
  expect_true(any(grepl("fgeo_elevation", pick_package("fgeo.tool")$alias)))
})

test_that("doesn't include package documentation", {
  skip_if_not_installed("fgeo")
  expect_false(any(grepl("fgeo-package", unique(search_help("fgeo")$alias))))
})



context("pick_concept")

test_that("known concept retrieves known alias", {
  retrieved_docs <- pick_concept("combine strings")$alias
  expect_true(any(grepl("paste", unique(retrieved_docs)))
  )
})

test_that("no longer picks demography_impl", {
  skip_if_not_installed("fgeo.analyze")
  skip_if_not_installed("fgeo")

  result <- pick_concept(
    "demography functions",
    url = NULL,
    packages = fgeo:::fgeo_packages()
  )$topic

  expect_false(any(grepl("demography_impl", result)))
  expect_true(any(grepl("demography_ctfs", result)))
})



context("reference_package")

test_that("works with fgeo", {
  skip_if_not_installed("fgeo")
  expect_is(reference_package("fgeo"), "data.frame")
  expect_is(reference_package("fgeo", url = "https://..."), "data.frame")
})

test_that("works with tidyverse packages", {
  expect_is(reference_package("dplyr", url = "https://..."), "data.frame")
})

test_that("works with base packages", {
  expect_is(reference_package("base"), "data.frame")
  expect_is(reference_package("utils"), "data.frame")
  expect_is(reference_package("stats"), "data.frame")
})

test_that("works with MASS", {
  expect_is(reference_package("MASS"), "data.frame")
})
