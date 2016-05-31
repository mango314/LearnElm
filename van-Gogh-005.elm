import Html exposing (..)
import Html.App as Html
-- https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/Image
import Element exposing (image, toHtml)
import Random  exposing (..)
import Collage exposing (..)

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

subscriptions: Model -> Sub msg
subscriptions model = Sub.none

-- MODEL
type alias Model = Int

model : Model
model = 0

-- VIEW

view: Model -> Html msg
view model = toHtml ( image width height "starry-night.jpg" )

-- UPDATE

type Msg = Int
update: Msg -> Model -> (Model, Cmd msg)
update msg model = ( model, Cmd.none)


-- INIT

init: (Model, Cmd Msg)
init = ( 1, Cmd.none)
