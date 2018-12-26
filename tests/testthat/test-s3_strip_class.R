context("s3_strip_class")

test_that("no longer fails with objects starting with dot", {
  expect_equal(s3_strip_class(".something"), ".something")
})

test_that("no longer fails with dplyr::all.equal.tbl_df", {
  expect_is(s3_strip_class(c("all.equal.tbl_df")), "character")
})

test_that("fails with informative message", {
  expect_error(s3_strip_class(), "missing")
})

test_that("does nothing with non existing functions", {
  expect_equal(s3_strip_class("not_a_function"), "not_a_function")
})

test_that("outputs expected generics", {
  skip_if_not_installed("fgeo.analyze")
  library(fgeo.analyze)

  expect_equal(
    s3_strip_class(c(
      "print.data.frame",
      "to_df.tt_lst",
      "print"
    )),
    c("print", "to_df", "print")
  )
})
