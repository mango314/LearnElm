import Html exposing (Html, Attribute, button, div, text)
import Html.Events exposing (onClick)
import Svg exposing (Svg, svg, g, polygon)
import Svg.Attributes exposing (points)

import Http
import Json.Decode as Decode exposing (Decoder, at, list, maybe, map, map2, field, float, oneOf, string)
import Html.Attributes exposing (style)

main =
  Html.program { init = init, view = view, update = update , subscriptions = subscriptions }

type Msg = GetMap ( Result Http.Error ( List ( Maybe Polygon ) ) ) | AskMap

-- INIT

type alias Model   =   { note:  String, polygons: List ( Maybe Polygon ) }

type alias Polygon =   { name: String, coordinates: List ( List ( List Float )) }

type alias MultiPolygon = { name: String , coordinates: List ( List ( List ( List Float ))) }

-- > type Qqq = Abc String | Xyz Int
-- > Abc
-- <function> : String -> Repl.Qqq


type Town =  Foo MultiPolygon | Bar Polygon


-- type Poly = Muni Polygon | MuniPoly MultiPolygon

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
divStyle = style [("width", "250px"), ("display", "inline-block"), ("margin-left", "5px")]

svgStyle : Html.Attribute Msg
svgStyle = style [ ("width", "450px"), ("height", "150px"), ("background-color", "#FAFAFA"), ("margin", "5px") ]

f : List ( List Float ) -> Int
f x = ( List.sum << ( List.map (\a -> 1 ) ) ) x

h: Polygon -> String
h x =
  (   String.concat
  <<      List.map ( String.join " " ) 
  <<  (   List.map << List.map  ) ( String.join "," )
  <<  ( ( List.map << List.map << List.map ) (\t -> toString t) )
  ) x.coordinates

drawTiles : Maybe Polygon -> Svg Msg
drawTiles x  = case x of
  Nothing -> polygon [] []
  Just y  -> polygon [ points <| h y ] []

view model =
  div [ ]
    [ div [ divStyle ] [ text model.note ]
    , div [ divStyle ] [ button [ onClick AskMap ] [ text "get Map" ] ]
    , div [ ] [ svg [ svgStyle ] [ g [] <| List.map drawTiles model.polygons ]  ]
    , div []
        <| List.map
            (\x ->
              case x of
                Just y -> div [ divStyle ]
                  [ text "# elements: "
                  , ( text << toString << List.sum << ( List.map f ) ) y.coordinates
                  ]
                Nothing -> div [ divStyle ] [ text "nothing"]
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
decodePR = ( ( at ["municipios"] ) << list << maybe ) ( oneOf  [ polygonDecoder ] )

polygonDecoder : Decoder Polygon
polygonDecoder = map2 Polygon
  ( at [ "properties", "NAME" ] string )
  ( at [ "geometry", "coordinates" ] <| ( list << list << list ) ( float ) )

multiPolygonDecoder : Decoder MultiPolygon
multiPolygonDecoder = map2 MultiPolygon
  ( at [ "properties", "NAME" ] string )
  ( at [ "geometry", "coordinates" ] <| ( list << list << list << list ) ( float ) )
