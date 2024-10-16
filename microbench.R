library(microbenchmark)
library(mapsf)
library(sf)
library(gepaf)
m <- mf_get_mtq()
m <- st_transform(m, "EPSG:4326")
xx <- st_coordinates(m)
df <- data.frame(lat = round(xx[1:1000,2], 5), lon = round(xx[1:1000,1], 5))
poly <- encodePolyline(df[1:3, ])

microbenchmark(
  encode = encodePolyline(df),
  decode = decodePolyline(poly),
  times = 100)



microbenchmark(list(NULL, NULL), vector("list", 2), times = 10000)


x <- decodePolyline(poly)

x
