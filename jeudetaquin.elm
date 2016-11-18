-- Elm v0.18
-- Monte Carlo simulation to compute the value of pi by finding the odds of a
-- a randomly thrown ball to fall inside a circle
import Html exposing (Html, button, div, text, beginnerProgram)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style)

import Svg exposing (svg, rect, line, circle, Svg)
import Svg.Attributes exposing ( width, height, fill, stroke, x1, x2, y1, y2, strokeWidth, cx, cy, r)

import Random exposing (list, pair, float)

main =
  Html.program { init = init  , view = view, update = update , subscriptions = subscriptions}


type alias Model = { pts: List (Float, Float)}

type Point = Float Float

type Msg = Generate | NewPoints ( List (Float, Float) )

init : (Model, Cmd Msg)
init = ( Model [], Cmd.none)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    Generate ->
      (model, Random.generate NewPoints ( list 19 <| pair (float 0 1 ) (float 0 1 ) ) )
    NewPoints x ->
      ( Model x, Cmd.none )

f : Int -> Int -> Svg Msg
f a b =  line [ x1 (toString <| (a+1)*25 ), y1 (toString <| (b+1)*25  ), x2 (toString <| (a+19)*25 ), y2 (toString <| (b+ 1)*25 ), stroke "black" , strokeWidth "2" ] []

g : Int -> Int -> Svg Msg
g a b =  line [ x1 (toString <| (a+1)*25 ), y1 (toString <| (b+1)*25  ), x2 (toString <| (a+ 1)*25 ), y2 (toString <| (b+19)*25 ), stroke "black" , strokeWidth "2" ] []

h: (Int, Int) -> Svg Msg
h (a, b) =  circle [ cx ( toString <| (a+1)*25 ) , cy (toString <| (b+1)*25) , r (toString 5) ] []

k: (Int, Int) -> Svg Msg
k (a,b) =  circle [ cx ( toString <| (a+1)*25 ) , cy (toString <| (b+1)*25) , r (toString 5) ] []

floor2: (Float, Float) -> (Int, Int)
floor2 (a,b) = ( floor (19*a), floor (19*b))

sort: List (Float, Float) -> List (Int, Int)
sort x = List.map floor2 x

view: Model -> Html Msg
view model =
  div []
    [ div [style [ ("width", "500") ] ]
      [ text "Go Board",
        button [onClick Generate, style [ ("width", "75px") ] ] [ text "new pts" ]
      ]
    , div [] [ svg [ width "500", height "500" ] <|
        [ rect [ width "500", height "500", fill "#DCFFB4"] []
        ] ++
        ( List.map (\c -> f 0 c) <| List.range 0 18 ) ++
        ( List.map (\c -> g c 0) <| List.range 0 18 ) ++
--        ( List.map h [ (3,3), (3,9), (3,15), (9,3), (9,9), (9,15), (15,3), (15,9), (15,15) ] ) ++
        ( List.map k <| sort model.pts )
      ]
    ]

subscriptions: Model -> Sub Msg
subscriptions model = Sub.none
