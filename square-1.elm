import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)


-- collage : Int -> Int -> List Form -> Element

main : Element
main =
  collage 250 450
    [ move (-55,  -55 )   blueSquare
    , move (-55,   55 )    redSquare
    , move ( 55,  -55 )  greenSquare
    , move ( 55, 3*55 ) yellowSquare
    ]
    



-- traced : LineStyle -> Path -> Form

blueSquare : Form
blueSquare =
  traced (dashed blue) square



redSquare : Form
redSquare  =
  traced ( solid red) square
  
greenSquare : Form
greenSquare =
  traced (solid green ) square
  
yellowSquare : Form
yellowSquare = 
  traced (dotted yellow) square

-- path : List ( Float, Float ) -> Path

square : Path
square =
  path [ (50,50), (50,-50), (-50,-50), (-50,50), (50,50) ]
