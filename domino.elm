-- homework: remove all the repetetive parts using functoriality!
import Html exposing (Html, button, div, text, p)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style)
import Svg exposing (Svg, svg, polygon, polyline, line, g, rect )
import Svg.Attributes exposing (points, stroke, strokeWidth, fill, x1, x2, y1, y2, width, height, x, y)

-- idea:
--
-- implement domino tiling as a data structure over a dictionary.
-- if every square can be referred to by a pair of integers maybe
--

main =
  Html.beginnerProgram { model = 0, view = view, update = update }

type Msg = Increment | Decrement

update msg model =
  case msg of
    Increment ->
      model + 1

    Decrement ->
      model - 1

tile x = polygon
  [ points
  <| String.join " "
  <| List.map ((\(a,b) -> toString a ++ "," ++ toString b) <<  (\(a,b) -> (a+20, b+20)) << (\(a,b) -> (92*a , 92*b) ) ) x
  , stroke "#707070"
  , fill "none"
  , strokeWidth "3"
  ]
  []

view model =
  div []
    [ div []
      [ svg [ style [ ( "width", "500"), ("height", "500"), ("background-color", "#F0F0F0")] ]
          [ g []
                    <| List.map (\a -> line
                      [ x1 (toString a)
                      , x2 (toString a)
                      , y1 (toString 20)
                      , y2 (toString 480)
                      , strokeWidth "1"
                      , stroke "#3CE875"  ] [] )
                    <| List.map (\x -> x)
                    <| List.map (\x -> 20 + 92*x ) [0,1,2,3,4,5]
          , g []
                    <| List.map (\a -> line
                      [ x1 (toString 20)
                      , x2 (toString 480)
                      , y1 (toString a)
                      , y2 (toString a)
                      , strokeWidth "1"
                      , stroke "#3CE875"  ] [] )
                    <| List.map (\x -> x)
                    <| List.map (\x -> 20 + 92*x  ) [0,1,2,3,4,5]
          , tile [(0,0), (1, 0),(2,0),(2,1),(1,1),(0,1),(0,0)]
          , tile [(2,0), (3, 0),(3,1),(3,2),(2,2),(2,1),(2,0)]
          , tile [(3,0), (4, 0),(5,0),(5,1),(4,1),(3,1),(3,0)]
          , tile [(3,1), (4, 1),(4,2),(4,3),(3,3),(3,2),(3,1)]
          , tile [(4,1), (5, 1),(5,2),(5,3),(4,3),(4,2),(4,1)]
          , tile [(3,3), (4, 3),(5,3),(5,4),(4,4),(3,4),(3,3)]
          , tile [(3,4), (4, 4),(5,4),(5,5),(4,5),(3,5),(3,4)]
          , tile [(0,1), (1, 1),(1,2),(1,3),(0,3),(0,2),(0,1)]
          , tile [(1,1), (2, 1),(2,2),(2,3),(1,3),(1,2),(1,1)]
          , tile [(0,3), (1, 3),(2,3),(2,4),(1,4),(0,4),(0,3)]
          , tile [(1,4), (2, 4),(3,4),(3,5),(2,5),(1,5),(1,4)]
          ]
      ]
    ]
