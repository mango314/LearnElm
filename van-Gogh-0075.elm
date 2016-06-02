port module VanGogh exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as Html
-- https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/Image
import Element exposing (image, toHtml)
-- import Random  exposing (..)
-- import Collage exposing (..)

import String
import List
import Task

width  = 960
height = 500

--main = toHtml ( image width height "starry-night.jpg" )

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

-- subscriptions

port getImageData : () -> Cmd msg

port pixels : ( (List Int) -> msg ) -> Sub msg

subscriptions: Model -> Sub Msg
subscriptions model = pixels Points

-- MODEL
-- type alias Model = List (Int, Int)
type alias Model = {pts : List  Int }


-- VIEW

view: Model -> Html Msg
view model = div [ class "title"]
  [ h1 [] [ Html.text "Voronoi Tesslation Collage" ]
  , h2 [] [ Html.text ( String.join ", " ( List.map toString  model.pts ) ) ]
  , toHtml ( image width height "starry-night.jpg" )
  ]

-- UPDATE

type Msg = GetData | Points (List Int) | Polygons


update: Msg -> Model -> (Model, Cmd msg)
update msg model =
  case msg of
    GetData  -> (model, getImageData () )
    Points x -> ( Model x, Cmd.none )
    Polygons -> (model, Cmd.none)


-- INIT

init: (Model, Cmd Msg)
init = ( Model [1,2,3,4], send GetData )

send : msg -> Cmd msg
send msg =
  Task.perform identity identity (Task.succeed msg)
