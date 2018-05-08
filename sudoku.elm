import Html exposing (Html, div, h1, text)
import Html.Attributes  exposing (style)
import Svg exposing (Svg, svg, rect)
import Svg.Attributes exposing (x,y, height)
import Time exposing (Time, second)
import Dict exposing (Dict, empty)


main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


-- MODEL

type alias Model = Sudoku

type alias Sudoku = List (List Int)

init : (Model, Cmd Msg)
init =
  (
  [ [1,2,3,4,5,6,7,8,9]
  , [1,2,3,4,5,6,7,8,9]
  , [1,2,3,4,5,6,7,8,9]
  , [1,2,3,4,5,6,7,8,9]
  , [1,2,3,4,5,6,7,8,9]
  , [1,2,3,4,5,6,7,8,9]
  , [1,2,3,4,5,6,7,8,9]
  , [1,2,3,4,5,6,7,8,9]
  , [1,2,3,4,5,6,7,8,9]
  ] , Cmd.none )


-- UPDATE

type Msg
  = Click


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Click ->
      (model, Cmd.none)

-- should be able to valideate diagonal sudoku or other variants
validate : Model -> Bool
validate model = True

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none


-- VIEW

boxStyle : Html.Attribute msg
boxStyle = style
  [ ("backgroundColor", "#DDDDDD")
  , ("width", "40px")
  , ("height", "40px")
  , ("margin", "5px")
  , ("display","inline-block")
  , ("padding-top", "5px")
  , ("font-family", "Courier")
  , ("font-size", "30px")
  , ("vertical-align", "middle")
  , ("text-align", "center")]

row : List Int -> Html Msg
row data = div [] [ div [] <| List.map (\x -> div [ boxStyle ] [ ( text << toString)  x] ) data ]


sudokuGrid : Html Msg
sudokuGrid =   div [ Html.Attributes.style [("width", "1000px"), ("height", "1000px")]  ]
    [ row (List.range 0 8)
    , row (List.range 0 8)
    , row (List.range 0 8)
    , svg [ height "10px" ] [ rect [ height "10px" ] [] ]
    , row (List.range 0 8)
    , row (List.range 0 8)
    , row (List.range 0 8)
    , svg [ height "10px" ] [ rect [ height "10px" ] [] ]
    , row (List.range 0 8)
    , row (List.range 0 8)
    , row (List.range 0 8)
    ]

view : Model -> Html Msg
view model =
  div [ Html.Attributes.style [("margin-left", "5px")]  ] [ h1 [] [text "Sudoku"], sudokuGrid ]
