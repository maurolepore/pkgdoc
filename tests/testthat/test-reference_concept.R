test_that("errors if some concept is not matched", {
  expect_error(
    reference_concept(c("combine strings", "bad concept")),
    "No concept matches.*bad concept"
  )
})

test_that("is sensitive to `concept`", {
  out <- reference_concept("combine strings", packages = "base")
  expect_equal(unique(out$topic), "paste")
})

test_that("is sensitive to `packages`", {
  out <- reference_concept("combine strings", packages = "base")
  expect_equal(unique(out$package), "base")
})
