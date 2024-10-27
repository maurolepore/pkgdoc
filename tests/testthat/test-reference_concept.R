test_that("warns if some concept is not matched", {
  expect_error(
    reference_concept(c("combine strings", "bad concept")),
    "No concept matches.*bad concept"
  )
})

test_that("picks one topic & is sensitive to `packages`", {
  expect_equal(
    reference_concept("combine strings", packages = "base")$topic,
    "paste"
  )
})
