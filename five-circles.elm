import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)

check : Signal.Mailbox Int
check x = Signal.mailbox x

main: Element
main = 
  collage 500 500
    ( List.map (\x -> box  ) [ 0, 1, 2, 3, 4])
    
    
f x = clickable ( Signal.message  )  (move ( 0, 50*x) (filled red (circle 10)))
