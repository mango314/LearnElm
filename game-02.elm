import Html exposing (Html, button, div, text, p)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style)
import Svg exposing (Svg, svg, rect, g)
import Time exposing (Time, second)
import Random exposing (int, Generator)
import Svg.Attributes exposing (width, height, x, y, stroke, fill, strokeWidth)
import Dict exposing (..)


-- example of time

main = Html.program { init = init, view = view, update = update, subscriptions = subscriptions}


-- INIT
-- surprise the random number generator must be part of the model

type alias Model = { time: Time, board: Dict (Int, Int) String}

init : (Model, Cmd Msg)
--init = ({time = 0, board = Dict.fromList <| List.map (\x -> (x, getRandomColor x ) ) <| product (List.range 0 5) (List.range 0 5) }, Cmd.none)
init = (
  {time = 0*second
  , board = Dict.fromList
    ( List.map (\(a,b) -> case Dict.get a color of
    Nothing -> (b, "none" )
    Just x  -> (b, x)  )
    <|  List.map2
        (,)
        ( Tuple.first ( Random.step ( Random.list (6*6) (Random.int 0 4) ) (Random.initialSeed 31415 ) ) )
    <| product (List.range 0 5) (List.range 0 5) )}
  , Cmd.none )

-- UPDATE

type Msg = Increment | Decrement | Tick Time | Click (Int, Int)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Increment     ->    ( {model | time = model.time + 1 } , Cmd.none)

    Decrement     ->    ( {model | time = model.time - 1 } , Cmd.none)

    Tick newTime  ->    ( {model | time = model.time + 1 } , Cmd.none)

    Click (x,y)   ->    (  model                           , Cmd.none)


-- VIEW

dice : Generator ( List Int )
dice =  Random.list (6*6) (Random.int 0 4)

--getRandomColor : (Int, Int) -> String
--getRandomColor (a,b) = case Dict.get ( dice ) color of
--  Nothing -> "#000000"
--  Just x  ->  x

color : Dict Int String
color = Dict.fromList [ (0, "#44EBAC"), (1,"#602FFF"), (2,"#E84C2B"), (3,"#E8D62A") ]

blinking : Html.Attribute Msg
blinking = style [ ]

row : Html.Attribute Msg
row = style [("display", "inline-block"), ("width", "25px")]

info : Html.Attribute Msg
info = style [("width", "300px")]

product : List a -> List b -> List (a,b)
product x y = List.concat <| List.map (\a -> List.map (\b -> (b,a) ) x ) y

view : Model -> Html Msg
view model =
  div [ style[("font-family", "Courier"), ("margin", "10px") ] ]
    [ div [ row ] [ button [ onClick Decrement ] [ text "-" ] ]
    , div [ row , style [("text-align", "center")] ] [ text (toString model.time) ]
    , div [ row ] [ button [ onClick Increment ] [ text "+" ] ]
    , div [ info ] [ p [] [ text "Rules: Click on the + button to increment, click on the - button to decrement." ] ]
    , div []
      [ svg []
        [ g []
          <|  List.map
          (\  (a,b) ->  rect
            [   width "15"
            ,   height "15"
            ,   case get (a,b) model.board of
                  Nothing -> fill "none"
                  Just d  -> fill d
            ,   stroke "#000000"
            ,   strokeWidth "1"
            ,   x (toString <| 25*a)
            ,   y (toString <| 25*b)
            ,   onClick <| Click (a,b)
            ] []
          ) <|  product (List.range 0 5) (List.range 0 5)
        ]
      ]
    ]

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model = Time.every second Tick
