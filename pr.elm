import Html exposing (Html, Attribute, button, div, text)
import Html.Events exposing (onClick)
import Svg exposing (Svg, svg)

import Http
import Json.Decode as Decode exposing (Decoder, at, list, maybe, map, field, float)
import Html.Attributes exposing (style)

main =
  Html.program { init = init, view = view, update = update , subscriptions = subscriptions }

type Msg = GetMap ( Result Http.Error   ( List ( Maybe Polygon ) ) ) | AskMap

-- INIT

type alias Model   =   { note:  String, polygons: List ( Maybe Polygon ) }

type alias Polygon = { coordinates: List ( List ( List Float )) }

init : ( Model, Cmd Msg )
init = ( Model "PR info" ( [] ) , Cmd.none )

-- UPDATE

update msg model =
  case msg of

    AskMap         -> ( model , getPRData  )

    GetMap (Ok x ) -> ( { model | polygons = x }    , Cmd.none )

    GetMap (Err _) -> ( { model | note =  "error" } , Cmd.none )

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
    [ div [ divStyle ] [ text model.note ]
    , div [ divStyle ] [ button [ onClick AskMap ] [ text "get Map" ] ]
    , div [ svgStyle ] [ svg [] []  ]
    , div []
        <| List.map
            (\x ->
              case x of
                Just y -> div []
                  [ text "abc"
                  , ( text << toString << List.sum << ( List.map (\t -> 1) ) ) y.coordinates
                  ]
                Nothing -> div [] [ text "nothing"]
            ) model.polygons
    ]

-- HTTP

getPRData : Cmd Msg
getPRData =
  let
    url = "http://localhost:8000/PR/PR.json"
  in
    Http.send GetMap <| Http.get url decodePR
    --Http.send GetMap <| Http.getString url

-- LANDMARK: this decoder works !
-- discussion on Elm decoders rather limited
-- Fajardo is Multipolygon

-- no monads!!
decodePR : Decoder  ( List ( Maybe Polygon ))
decodePR = ( ( at ["municipios"] ) << list << maybe ) ( polygonDecoder )

polygonDecoder : Decoder Polygon
polygonDecoder = map Polygon
  <|  field "coordinates"
  <|  at ["geometry", "coordinates"]
  <|  ( list << list << list )
  <|  float

decodePR2 : Decoder  ( List ( List ( List ( List ( List Float )))))
decodePR2 = at ["municipios"]
  <| list
  <| at ["geometry", "coordinates"]
  <| list <| list <| list <| list
  <| float
