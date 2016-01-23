import Html exposing (text)
import String

{- 
> f x = x + 1
<function> : number -> number
> g x = (Result.map f ) x
<function> : Result.Result a number -> Result.Result a number
> import String
> g(String.toInt "5")
Ok 6 : Result.Result String Int
> toString (g(String.toInt "5"))
"Ok 6" : String
> (Result.map toString )(g(String.toInt "5"))
Ok "6" : Result.Result String String
> import Html exposing (text)
> text "5"
{ text = "5", version = "2", type = "VirtualText" } : Html.Html
-}

f: Int -> Int
f x = x + 1

g: Result String Int -> Result String Int
g x = (Result.map f) x

main =
  text (  toString ( g  (String.toInt "5" ) ))
