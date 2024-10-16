#' @name encodePolyline
#' @title Encode Coordinates to Google Polylines
#' @description Encode a data.frame of coordinates to a Google polyline.
#' @param df_coords a data frame of coordinates with two columns: latitudes and
#' longitudes. Coordinates must be in decimal degrees (WGS84).
#' @param factor number of decimal digits to be used.
#' @return An encoded polyline is returned.
#' @examples
#' coords <- data.frame(
#'   lat = c(38.5, 40.7, 43.252),
#'   lon = c(-120.2, -120.95, -126.453)
#' )
#' encpoly <- encodePolyline(coords)
#' encpoly
#' @export
encodePolyline <- function(df_coords, factor = 5) {
  df_coords <- as.matrix(df_coords)
  factor <- 10^factor
  dims <- dim(df_coords)[1]
  output_string <- paste0(
    enc_coord(df_coords[1, 1], factor = factor),
    enc_coord(df_coords[1, 2], factor = factor)
  )
  for (i in seq(2, dims)) {
    output_string <- paste0(
      output_string,
      enc_coord(df_coords[i, 1] - df_coords[i - 1, 1], factor = factor),
      enc_coord(df_coords[i, 2] - df_coords[i - 1, 2], factor = factor)
    )
  }
  return(output_string)
}



## Encoding Utils
enc_coord <- function(coord, factor) {
  output <- ""
  pt <- round(coord * factor, digits = 0) * 2
  if (pt < 0) pt <- bitops::bitFlip(pt)
  while (pt >= 0x20) {
    output <- paste0(
      output,
      intToUtf8(bitops::bitOr(0x20, bitops::bitAnd(pt, 0x1f)) + 63)
    )
    pt <- bitops::bitShiftR(pt, 5)
  }
  return(paste0(output, intToUtf8(pt + 63)))
}

#' @name decodePolyline
#' @title Decode a Google Polyline to a Data Frame
#' @description Decode a Google polyline to a data frame of coordinates.
#' @param enc_polyline a Google polyline.
#' @param factor number of decimal digits to be used.
#' @return A data frame of latitudes and longitudes is returned.
#' @examples
#' coords <- decodePolyline(enc_polyline = "_p~iF~ps|U_ulLnnqC_mqNvxq`@")
#' coords
#' @export
decodePolyline <- function(enc_polyline, factor = 5) {
  factor <- 10^factor
  len <- nchar(enc_polyline)
  enc_polyline <- strsplit(enc_polyline, "")[[1]]
  idx <- 1
  res_idx <- lat <- lon <- 0
  changes <- list(NULL, NULL)
  l <- list(NULL)
  while (idx <= len) {
    for (u in c(1, 2)) {
      shift <- result <- 0
      while (TRUE) {
        byte <- as.integer(charToRaw(enc_polyline[idx])) - 63
        result <- bitops::bitOr(result, bitops::bitShiftL(bitops::bitAnd(byte, 0x1f), shift))
        idx <- idx + 1
        shift <- shift + 5
        if (byte < 0x20) break
      }
      changes[u] <- ifelse(test = bitops::bitAnd(result, 1),
        yes  = -(result - (bitops::bitShiftR(result, 1))),
        no   = bitops::bitShiftR(result, 1)
      )
    }
    lat <- lat + changes[[1]]
    lon <- lon + changes[[2]]
    res_idx <- res_idx + 1
    l[[res_idx]] <- c(lat, lon)
  }
  coords <- data.frame(do.call(rbind, l) / factor)
  names(coords) <- c("lat", "lon")
  return(coords)
}


