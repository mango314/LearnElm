import Html exposing (Html)

import Element exposing (image, toHtml)

main = toHtml ( image 960 500 "starry-night.jpg" )


{-

three main functions in mbstock's Starry Night Example

* best candidate sampler

 --- implement QUADTREE in Elm instead of messy Javascript

* d3.geom.voronoi

 --- borrow from d3.js using Elm's interOp

 * image data ---> voronoi( best candidate samples) -->  fill canvas with polygons 

 --- https://developer.mozilla.org/en-US/docs/Web/API/CanvasRenderingContext2D/getImageData

 --- also requires interOP

-}
