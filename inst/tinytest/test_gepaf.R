coords1 <- data.frame(lat = c(38.565482, 40.744872, 43.2525452),
                     lon = c(-120.254545, -120.954458, -126.453654))
encpoly1 <- encodePolyline(coords1)
coords2 <- data.frame(lat = c(38.56548, 40.74487, 43.25254),
                     lon = c(-120.25454, -120.95445, -126.45365))
encpoly2 <- encodePolyline(coords2)

expect_identical(encpoly1, encpoly2)
expect_equal(encpoly1, "gikjFze~|UethLlugC}whN~`q`@")
expect_identical(decodePolyline("gikjFze~|UethLlugC}whN~`q`@"), coords2)
