import Html exposing (Html, Attribute, text, toElement, div, input)
import Html.Attributes exposing (..)
import Html.Events exposing (on, targetValue)
import Signal exposing (Address)
import StartApp.Simple as StartApp
import String


main =
  StartApp.start { model = "", view = view, update = update }


--http://www.share-elm.com/sprout/56a3bfb0e4b070fd20da92c9
--import Graphics.Element exposing (show)
--main = show ( (List.map (f 41)) [1..41] )

-- http://primes.utm.edu/glossary/xpage/QuadraticResidue.html
-- possible use as "pure" random number generator... still researching
f: Int -> Int -> Int
f a p = (a*a)%p

g: Result String Int -> Int -> Result String Int
g p a  = ( Result.map (f a) ) p 



-- UPDATE

update newStr oldStr =
  newStr

-- MODEL


-- VIEW

view : Address String -> String -> Html
view address string =
  div []
    [ input
        [ placeholder "What are the Quadratic Residues?"
        , value string
        , on "input" targetValue (Signal.message address)
        , myStyle
        ]
        []
    , div [ myStyle ] [ text (  toString (  List.map ( g ( String.toInt string) ) [1..41] ) ) ]
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
