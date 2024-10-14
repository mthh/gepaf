library(microbenchmark)

library(mapsf)
library(sf)
m <- mf_get_mtq()
m <- st_transform(m, "EPSG:4326")
xx <- st_coordinates(m)
df <- data.frame(lon = xx[,1], lat = xx[,2])

mb <- microbenchmark(encode10 = encodePolyline(df[1:10, ]),
                     encode100 = encodePolyline(df[1:100, ]),
                     encode1000 = encodePolyline(df[1:1000, ]))

plot(mb, log = "y")
