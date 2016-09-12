import Html exposing (text)
import String

main =
  text <| String.concat <| List.map toString <| f [ 1, 2, 3]
  
  

f: List Int -> List Int
f x = 
  case x of
     a :: x' ->  (a+1)::x'
     []      ->  [5]
