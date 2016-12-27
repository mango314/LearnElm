-- every second i would like to drop a small circle in a random place
-- if it falls inside a largr circle color red
-- if it falls outside color it blue.

-- strategy: combine elements from Random and Time examples @ elm-lang.org
-- http://elm-lang.org/examples/random
-- http://elm-lang.org/examples/time

import Html exposing ( text, div, li, Html, ul )
import Html.Events exposing (..)
import Random

--import Svg exposing (..)
--import Svg.Attributes exposing (..)
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
    Tick s -> (model, Random.generate Update <| Random.pair (Random.int 0 400) (Random.int 0 400) )
    Update x -> ( Model <| model.lotto ++ [x] , Cmd.none)

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model = Time.every second Tick


-- VIEW
-- test view an HTML list of all the dice rolls

view : Model -> Html Msg
view model =
  div []
    [ ul [] <| List.map (\(a,b) -> li [] [text <| (toString a ) ++ " , "  ++ (toString b)] ) model.lotto
    ]