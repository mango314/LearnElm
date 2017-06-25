import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Svg exposing (Svg, svg)

import Http
import Json.Decode as Decode
import Html.Attributes exposing (style)

main =
  Html.program { init = init, view = view, update = update , subscriptions = subscriptions }

type Msg = GetMap ( Result Http.Error String ) | AskMap

-- INIT

type alias Model = String

init : ( Model, Cmd Msg )
init = ( "PR info" , Cmd.none )

-- UPDATE

update msg model =
  case msg of

    AskMap      ->  ( model , getPRData  )

    GetMap (Ok x ) -> ( x    , Cmd.none )

    GetMap (Err _) -> ( "error"  , Cmd.none )

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

-- VIEW

divStyle : Html.Attribute Msg
divStyle = style [("width", "250px"), ("display", "inline-block")]

svgStyle : Html.Attribute Msg
svgStyle = style [("width", "500px")]

view model =
  div [ ]
    [ div [ divStyle ] [ text model ]
    , div [ divStyle ] [ button [ onClick AskMap ] [ text "get Map" ] ]
    , div [ svgStyle ] [ svg [] []  ]
    ]

-- HTTP

getPRData : Cmd Msg
getPRData =
  let
    url = "http://localhost:8000/PR/PR.json"
  in
    Http.send GetMap <| Http.get url decodePR

decodePR : Decode.Decoder String
decodePR = Decode.at ["municipios"] Decode.string
