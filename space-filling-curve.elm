import Html exposing (Html, button, div, text, h1, textarea)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (style)
import Svg exposing (Svg, svg, polygon, node, line, g, circle, polyline )
import Svg.Attributes exposing (points, fill, stroke, strokeWidth, cx, x1, x2, cy, y1, y2, r)

main =
  Html.beginnerProgram { model = "", view = view, update = update }

type Msg = Type String

update msg model =
  case msg of
    Type newPath -> newPath

-- integrate the curvatuve of the path
f : List String -> List (Int, Int)
f x = [(0,0)]

calculatePath : String -> List (Int, Int)
calculatePath str = f <| String.split "" str

writePath : List (Int, Int) -> String
writePath x = String.join " " <| List.map (\(a,b) -> (toString a) ++ "," ++ (toString b)) x

dx : Int -> Int
dx x = 20 + 46 + 92*x

dy : Int -> Int
dy y = dx y

start : List (Int, Int) -> Svg msg
start x = case List.head x of
    Just pt -> circle
      [ cx <| toString <| dx <| Tuple.first pt
      , cy <| toString <| dy <| Tuple.second pt
      , r <| toString 10, stroke "none"
      , fill "#E8D62A" ] []
    Nothing -> circle
      [ cx <| toString <| dx 0
      , cy <| toString <| dy 0
      , r <| toString 10
      , stroke "none"
      , fill "#E8D62A" ] []

-- retrive correct value after iterating over the list of line segments.  return a tuple
finish : List (Int, Int) -> Svg msg
finish x = case List.head x of
    Just pt -> circle
      [ cx <| toString <| dx <| Tuple.first pt
      , cy <| toString <| dy <| Tuple.second pt
      , r <| toString 10, stroke "none"
      , fill "#E8D62A" ] []
    Nothing -> circle
      [ cx <| toString <| dx 0
      , cy <| toString <| dy 0
      , r <| toString 10
      , stroke "none"
      , fill "#E8D62A" ] []

toPath str = g [] [ start <| calculatePath str, polyline [ strokeWidth "1", stroke "#000000", points <| writePath <| calculatePath str ] [], finish <| calculatePath str]


view model =
  div [style [("padding-left", "5px")]]
    [ h1 [ style [("font-family", "Helvetica")] ]
      [ div [ style [("width", "300"), ("display", "inline-block")] ] [ text "space-filling curves" ]
      , div [ style [("width", "200"), ("display", "inline-block")] ] [ textarea [ style [("width", "200"), ("float", "right")], onInput Type ] [] ]
      ]
    , svg [ style [ ( "width", "500"), ("height", "500"), ("background-color", "#F0F0F0")] ]
      [ polygon
        [ stroke "#3CE875"
        , strokeWidth "3"
        , fill "none"
        , points
          <| String.join " "
          <| List.map (\(a,b) -> (toString a) ++ "," ++ (toString b))
          <| List.map (\(a,b) -> (20 + 115*a, 20 + 115*b)) [(0,0),(4,0), (4,4), (0, 4), (0,0)]
        ] []
      , g []
          <| List.map (\a -> line [ x1 (toString a), x2 (toString a), y1 (toString 20), y2 (toString 480), strokeWidth "1", stroke "#3CE875"  ] [] )
          <| List.map (\x -> x)
          <| List.map (\x -> 20 + 92*x ) [1,2,3,4]
      , g []
          <| List.map (\a -> line [ x1 (toString 20), x2 (toString 480), y1 (toString a), y2 (toString a), strokeWidth "1", stroke "#3CE875"  ] [] )
          <| List.map (\x -> x)
          <| List.map (\x -> 20 + 92*x  ) [1,2,3,4]
      , toPath model
      ]
    ]
