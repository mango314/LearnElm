-- every second i would like to drop a small circle in a random place
-- if it falls inside a largr circle color red
-- if it falls outside color it blue.

-- strategy: combine elements from Random and Time examples @ elm-lang.org
-- http://elm-lang.org/examples/random
-- http://elm-lang.org/examples/time

import Html exposing ( text, div, li, Html, ul, Attribute)
import Html.Attributes exposing ( style )
--import Html.Events exposing (..)
import Random

import Svg exposing ( Svg, svg, circle )
import Svg.Attributes exposing ( r, fill, cx, cy )
import Time exposing (Time, second)

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

-- MODEL

type alias Model = { lotto: List (Int, Int) }

init : (Model, Cmd Msg)
init = (Model [], Cmd.none)

-- UPDATE

type Msg = Tick Time | Update (Int, Int)

-- these look simultaneous to end-user these are three different events
update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Tick s -> (model, Random.generate Update <| Random.pair (Random.int 0 500) (Random.int 0 500) )
    Update x -> ( Model <| model.lotto ++ [x] , Cmd.none)

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model = Time.every ( 0.125 * second ) Tick


-- VIEW
-- test view an HTML list of all the dice rolls
-- https://color.adobe.com

red : String
red = "#EB895B"

blue : String
blue = "#3057E8"

style1 : Attribute msg
style1 = style [ ( "color",  red  ), ("font-family", "Helvetica") ]

style2 : Attribute msg
style2 = style [ ( "color",  blue ), ("font-family", "Helvetica") ]

-- how to resolve the spacing issue for text ?
f : (Int, Int) -> Html Msg
f (a,b) =
  if (a-250)*(a-250)+(b-250)*(b-250) < 250*250 then
    li [ style1 ] [ text <| (toString a ) ++ " , "  ++ (toString b)]
  else
    li [ style2 ] [ text <| (toString a ) ++ " , "  ++ (toString b)]

-- how to abstract away the inside/outside conditional structure?
g : (Int, Int) -> Html Msg
g (a,b) =
  if (a-250)*(a-250)+(b-250)*(b-250) < 250*250 then
    circle [ r "3", fill red  , cx <| toString a, cy <| toString b ] []
  else
    circle [ r "3", fill blue , cx <| toString a, cy <| toString b ] []

circles : Model -> List ( Svg Msg )
circles model = List.map g model.lotto

view : Model -> Html Msg
view model =
  div []
    [ div [ style [("height", "500px"),("width", "150px"),("overflow-y", "auto"), ("display", "inline-block")] ]  [ ul [] <| List.map f model.lotto ]
    , div [ style [("height", "500px"),("width", "500px"), ("display", "inline-block")] ]
      [ svg [ style [("height", "500px"),("width", "500px"), ("background-color", "#F0F0F0")]] <| circles model
      ]
    ]
