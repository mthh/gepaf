# gepaf: Google Encoded Polyline Algorithm Format
Encode and decode the Google Encoded Polyline Algorithm Format

#### Usage
**Encoding**
```R
> coords <- data.frame(lat = c(38.5, 40.7, 43.252),
+                      lon = c(-120.2, -120.95, -126.453))
> encpoly <- encodePolyline(coords)
> encpoly
[1] "_p~iF~ps|U_ulLnnqC_mqNvxq`@"
```

**Decoding**
```R
> coords <- decodePolyline(enc_polyline = "_p~iF~ps|U_ulLnnqC_mqNvxq`@")
> coords
     lat      lon
1 38.500 -120.200
2 40.700 -120.950
3 43.252 -126.453
```


#### Notes :
 - *Performances can probably be tuned up*
 - *Just a single file from which copy/paste the code*
 
#### References :
Mostly a translation of http://github.com/mthh/polyline_ggl/ (itself a modest translation (i.g no GeoJSON wrapper, etc.) of other well known available implementations such as [Node.js Mapbox](https://www.npmjs.com/package/polyline) one)
