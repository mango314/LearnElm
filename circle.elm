import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (on)
import Json.Decode as Decode
import Mouse exposing (Position)
import List exposing (..)

-- Exercise
-- #1 change square to circle
-- #2 change text to nothing
-- #3 place 3 of the on the page
-- #4 draw the circle through the 3 points

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


-- MODEL


type alias Model =
  { pieces: List Tile
  }

type alias Tile =
    { position : Position
    , drag : Maybe Drag
    }


type alias Drag =
    { start : Position
    , current : Position
    }


init : ( Model, Cmd Msg )
init =
  ( Model [ Tile (Position 200 200) Nothing , Tile (Position 400 200) Nothing ,  Tile (Position 200 400) Nothing ] , Cmd.none )

-- UPDATE


type Msg
    = DragStart Position Tile
    | DragAt Position Tile
    | DragEnd Position Tile


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  ( updateHelp msg model, Cmd.none )


updateHelp : Msg -> Tile
updateHelp msg =
  case msg of
    DragStart xy tile->
      Tile position (Just (Drag xy xy))

    DragAt xy tile ->
      Tile position (Maybe.map (\{start} -> Drag start xy) drag)

    DragEnd _ tile ->
      Tile (getPosition tile) Nothing



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch <| List.map tileSubscription model.pieces

tileSubscription : Model -> Sub Msg
tileSubscription tile =
  case tile.drag of
    Nothing ->
      Sub.none

    Just _ ->
      Sub.batch [ Mouse.moves DragAt tile , Mouse.ups DragEnd tile ]



-- VIEW


(=>) = (,)

tileView : Tile -> Html Msg
tileView tile =
  let
    realPosition =
      getPosition tile
  in
    div
      [ onMouseDown
      , style
          [ "background-color" => "#3C8D2F"
          , "cursor" => "move"

          , "width" => "50px"
          , "height" => "50px"
          , "border-radius" => "2px"
          , "position" => "absolute"
          , "left" => px realPosition.x
          , "top" => px realPosition.y

          , "color" => "white"
          , "display" => "flex"
          , "align-items" => "center"
          , "justify-content" => "center"
          ]
      ]
      [ text "O"
      ]

view : Model -> Html Msg
view model =
    div
        [ style
            [ "width" => "100%"
            , "height"=> "100%"
            ]
        ] <|  List.map tileView model.pieces


px : Int -> String
px number =
  toString number ++ "px"


getPosition : Tile -> Position
getPosition {position, drag} =
  case drag of
    Nothing ->
      position

    Just {start,current} ->
      Position
        (position.x + current.x - start.x)
        (position.y + current.y - start.y)


onMouseDown : Attribute Msg
onMouseDown =
  on "mousedown" (Decode.map DragStart Mouse.position)
