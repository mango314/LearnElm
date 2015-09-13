import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Mouse
import Signal


-- Mouse.isDown is true whenever the left mouse button
-- is pressed down and false otherwise.

main : Signal Element
main =
  Signal.map g Mouse.isDown
    
    
g: Bool -> Element  
g x = 
  collage 200 420 (f x) 
 
f : Bool -> List Form
f x = 
 if x then [move (0,-55) blueSquare] else [move (0,55) redSquare]


-- Try clicking. The boolean value will update automatically.

blueSquare : Form
blueSquare =
  traced (dashed blue) square


redSquare : Form
redSquare =
  traced (solid red) square


square : Path
square =
  path [ (50,50), (50,-50), (-50,-50), (-50,50), (50,50) ]
