import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (on)
import Json.Decode as Decode
import Mouse exposing (Position)
import Svg exposing (Svg, svg, rect)
import Svg.Attributes exposing (width, height, color, fill, x, y)

import Dict exposing (fromList, update, insert, Dict )

-- objective: three squares you can click and drag (representing the 50 states)

main = Html.program
  { init = init
  , view = view
  , update = update
  , subscriptions = subscriptions
  }

-- Model

type alias Model = Dict Int Tile

type alias Tile =
  { position : Position
  , drag : Maybe Drag
  }

type alias Drag =
  { start   : Position
  , current : Position
  }

init : ( Dict Int Tile, Cmd Msg)
init =
  ( Dict.fromList
    [ ( 1, Tile ( Position 100 200 ) Nothing )
    , ( 2, Tile ( Position 200 200 ) Nothing )
    , ( 3, Tile ( Position 300 200 ) Nothing )
    ]
  , Cmd.none
  )

-- UPDATE

type Msg =
  DragStart Int Position  | DragAt Int Position | DragEnd Int Position

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = ( f msg model, Cmd.none)

f : Msg -> Model -> Model
f msg model =
  case msg of
    DragStart n xy -> insert n ( Tile (getTile n model).position (Just (Drag xy xy)) ) model
    DragAt    n xy -> insert n ( Tile (getTile n model).position (Maybe.map (\{start} -> Drag start xy) (getTile n model).drag) ) model
    DragEnd   n xy  -> insert n ( Tile (getPosition (getTile n model)) Nothing)  model

getPosition : Tile -> Position
getPosition {position, drag} =
  case drag of
    Nothing ->
      position

    Just {start,current} ->
      Position
        (position.x + current.x - start.x)
        (position.y + current.y - start.y)


-- SUBSCRIPTIONS

getTile : Int -> Model -> Tile
getTile n model =
  case Dict.get n model of
        Just a  -> a
        Nothing -> Tile ( Position (100*n) 200 ) Nothing

subscriptions: Model -> Sub Msg
subscriptions model =
  Sub.batch <| List.map (\n -> g n <| getTile n model ) [1,2,3]

g : Int -> Tile -> Sub Msg
g n tile =
  case tile.drag of
    Nothing -> Sub.none
    Just _  -> Sub.batch [ Mouse.moves ( DragAt n) , Mouse.ups ( DragEnd n ) ]

box : Int -> Tile -> String -> Svg Msg
box n t col = rect
  [ width  "10"
  , height "10"
  , x (toString t.position.x)
  , y (toString t.position.y)
  , fill col
  , onMouseDown n ] [ ]

-- VIEWS

view : Model -> Html Msg
view model = svg
  [ width "500"
  , height "500"
  , style [ ("margin", "10") ]
  ]
  [ rect [ width "100%", height "100%", fill "#F0F0F0" ] [ ]
  , box 1 ( getTile 1 model ) "#FF0000"
  , box 2 ( getTile 2 model ) "#00FF00"
  , box 3 ( getTile 3 model ) "#0000FF"
  ]

onMouseDown : Int -> Attribute Msg
onMouseDown x = on "mousedown" ( Decode.map (DragStart x) Mouse.position )
