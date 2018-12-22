context("strip_s3class")

test_that("outputs expected generics", {
  expect_equal(strip_s3class("print.data.frame"), "print")
  library(fgeo.analyze)
  expect_equal(
    strip_s3class(
      c(
        "print.data.frame",
        "to_df.tt_lst",
        "print"
      )
    ),
    c("print", "to_df", "print")
  )
})
