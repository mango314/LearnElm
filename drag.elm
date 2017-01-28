import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (on)
import Json.Decode as Decode
import Mouse exposing (Position)
import Svg exposing (Svg, svg, rect)
import Svg.Attributes exposing (width, height, color, fill, x, y)

-- objective: three squares you can click and drag (representing the 50 states)

main = Html.program
  { init = init
  , view = view
  , update = update
  , subscriptions = subscriptions
  }

-- Model

type alias Model = { a: Tile, b: Tile, c: Tile }

type alias Tile =
  { position : Position
  , drag : Maybe Drag
  }

type alias Drag =
  { start   : Position
  , current : Position
  }

init : (Model, Cmd Msg)
init =
  ( Model
    ( Tile ( Position 100 200 ) Nothing )
    ( Tile ( Position 200 200 ) Nothing )
    ( Tile ( Position 300 200 ) Nothing )
  , Cmd.none
  )

-- UPDATE

type Msg =
  DragStart (Model -> Tile) Position  | DragAt (Model -> Tile) Position | DragEnd (Model -> Tile) Position

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = ( f msg model, Cmd.none)

f : Msg -> Model -> Model
f msg model =
  case msg of
    DragStart tile xy -> model
    DragAt    tile xy -> model
    DragEnd   tile xy -> model

-- SUBSCRIPTIONS

subscriptions: Model -> Sub Msg
subscriptions model = Sub.batch [ g model.a (\x -> x.a), g model.b (\x -> x.b), g model.c (\x -> x.c) ]

g : Tile -> ( Model -> Tile ) -> Sub Msg
g tile getTile =
  case tile.drag of
    Nothing -> Sub.none
    Just _  -> Sub.batch [ Mouse.moves ( DragAt getTile ) , Mouse.ups ( DragEnd getTile ) ]

box : Tile -> ( Model -> Tile ) -> String -> Svg Msg
box t getTile col = rect
  [ width  "10"
  , height "10"
  , x (toString t.position.x)
  , y (toString t.position.y)
  , fill col
  , onMouseDown getTile ] [ ]

-- VIEWS

view : Model -> Html Msg
view model = svg
  [ width "500"
  , height "500"
  , style [ ("margin", "10") ]
  ]
  [ rect [ width "100%", height "100%", fill "#F0F0F0" ] [ ]
  , box model.a (\x -> x.a) "#FF0000"
  , box model.b (\x -> x.b) "#00FF00"
  , box model.c (\x -> x.c) "#0000FF"
  ]

onMouseDown : (Model -> Tile) -> Attribute Msg
onMouseDown getTile = on "mousedown" ( Decode.map (DragStart getTile) Mouse.position )
