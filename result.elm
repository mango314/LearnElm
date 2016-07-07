import Html exposing (text)
import String

f: Int -> Int
f x = x + 1

g: Result String Int -> Result String Int
g x = (Result.map f) x

h x =
    case x of
        Ok value -> toString(value + 1)
        Err msg  -> "Try a different value"

main =
  text (  toString ( h (g  (String.toInt "x" ) )))
