import Html exposing (Html, Attribute, text, toElement, div, input)
import Html.Attributes exposing (..)
import Html.Events exposing (on, targetValue)
import Signal exposing (Address)
import StartApp.Simple as StartApp
import String


main =
  StartApp.start { model = "", view = view, update = update }

--import Html exposing (text)
--import String

f: Int -> Int
f x = x + 1

g: Result String Int -> Result String Int
g x = (Result.map f) x


h x = 
    case x of 
        Ok value -> toString(value + 1)
        Err msg  -> "Please enter a number :-)"

--main =
--  text (  toString ( h (g  (String.toInt "x" ) )))

update newStr oldStr =
  newStr


view : Address String -> String -> Html
view address string =
  div []
    [ input
        [ placeholder "Text to reverse"
        , value string
        , on "input" targetValue (Signal.message address)
        , myStyle
        ]
        []
    , div [ myStyle ] [ text ( h (String.toInt string) )]
    ]


myStyle : Attribute
myStyle =
  style
    [ ("width", "100%")
    , ("height", "40px")
    , ("padding", "10px 0")
    , ("font-size", "2em")
    , ("text-align", "center")
    ]
