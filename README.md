
<!-- README.md is generated from README.Rmd. Please edit that file -->

# gepaf

<!-- badges: start -->

[![CRAN](https://www.r-pkg.org/badges/version-ago/gepaf)](https://cran.r-project.org/package=gepaf)
[![status](https://tinyverse.netlify.app/badge/gepaf)](https://CRAN.R-project.org/package=gepaf)
[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
<!-- badges: end -->

The goal of gepaf is to encode and decode the Google Encoded Polyline
Algorithm Format.

## Example

**Encoding**

``` r
library(gepaf)
coords <- data.frame(lat = c(38.5, 40.7, 43.252),
                     lon = c(-120.2, -120.95, -126.453))
encpoly <- encodePolyline(coords)
encpoly
#> [1] "_p~iF~ps|U_ulLnnqC_mqNvxq`@"
```

**Decoding**

``` r
coords <- decodePolyline(enc_polyline = "_p~iF~ps|U_ulLnnqC_mqNvxq`@")
coords
#>      lat      lon
#> 1 38.500 -120.200
#> 2 40.700 -120.950
#> 3 43.252 -126.453
```

## References :

Mostly a translation of <http://github.com/mthh/polyline_ggl/> (itself a
modest translation (i.g no GeoJSON wrapper, etc.) of other well known
available implementations such as [Node.js
Mapbox](https://www.npmjs.com/package/polyline) one)

## Alternative

- [`googlePolylines`](https://CRAN.R-project.org/package=googlePolylines)
