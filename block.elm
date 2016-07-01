import Html exposing (..)
import Html.App as Html
import Html.Events exposing (..)
import Random
import Svg exposing (..)
import Html.Attributes exposing (..)

main =
  Html.program
  { init = init
  , view = view
  , update = update
  , subscriptions = subscriptions
  }

-- Model

type alias Model = { state: Int }

init : (Model, Cmd Msg)
init = (Model 1, Cmd.none)

-- view

view : Model -> Html Msg
view model =
  div [ ]
    [ graphic
    , codesample
    ]

codesample : Html Msg
codesample = pre [ myStyle , Html.Attributes.id "code" ]
  [ code [  ] [ Html.text thisCode ]
  ]

graphic : Html Msg
graphic = div [ myStyle ] [ Svg.text "Hello World! Graphics will go here..." ]

myStyle : Html.Attribute Msg
myStyle = Html.Attributes.style [("background-color", "#F0F0F0"), ("width", "500px")]

-- update


type Msg
  = Roll  | NewFace Int

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = ( model , Cmd.none )

-- subscriptions

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

-- other

thisCode : String
thisCode = """
import Html exposing (..)
import Html.App as Html
import Html.Events exposing (..)
import Random
import Svg exposing (..)

main =
  Html.program
  { init = init
  , view = view
  , update = update
  , subscriptions = subscriptions
  }

-- Model

type alias Model = { state: Int }

init : (Model, Cmd, Msg)
init = (Model 1, Cmd.none)

-- view

view : Model -> Html Msg
view model =
  div []
    [ codesample
    , graphic
    ]

codesample : Html Msg
codesample = pre []
  [ code [] [ text thisCode ]
  ]

graphic : Html Msg

-- update

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = ( model , Cmd.none )

-- subscriptions

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none
"""
