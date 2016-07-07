import Color exposing (..)
import Collage exposing (..)
import Element exposing (..)
import Html exposing (..)


-- collage : Int -> Int -> List Form -> Element

main : Html msg
main =
   toHtml <| collage 250 450
    [ move (-55,  -55 )   blueSquare
    , rotate (degrees -90)  ( move (-55,   55 )    redSquare )
    , rotate (degrees  90)  ( move ( 55,  -55 )  greenSquare )
    , move ( 55,  55 ) yellowSquare
    ]

--
varDashed x y = LineStyle x 2 Flat Smooth y 10

-- traced : LineStyle -> Path -> Form

blueSquare : Form
blueSquare =
  traced (varDashed blue [8,4,4,4] ) square

redSquare : Form
redSquare  =
  traced (solid red) square

greenSquare : Form
greenSquare =
  traced (solid green ) square

yellowSquare : Form
yellowSquare =
  traced (varDashed yellow [8,4] ) square

-- path : List ( Float, Float ) -> Path

square : Path
square =
  path [ (0,50), (0,0), (50,0), (50,-50), (-50,-50), (-50,50),  (0,50) ]
