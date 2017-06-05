import Html exposing (Html, button, div, text, h1, textarea)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (style)
import Svg exposing (Svg, svg, polygon, node, line, g, circle, polyline )
import Svg.Attributes exposing (points, fill, stroke, strokeWidth, cx, x1, x2, cy, y1, y2, r, fill)

-- TWO STEPS:
--
-- design user interface
-- solve geometry problem

main =
  Html.beginnerProgram { model = Model [(0,0)] (0,0) (0,0) "" , view = view, update = update }

type alias Model = { pathNum: List (Int, Int), start: (Int, Int), end: (Int, Int), pathString : String }

type Msg = Type String | Left | Right | Up | Down | Restart

alphabet : List String
alphabet = [ "l", "L", "r", "R", "u", "U", "d", "D" ]

clean : String -> String
clean x =   ( String.toUpper << String.concat << (\data -> List.filter (\x -> List.member x alphabet ) data ) << (\t -> String.split "" t) ) x

update : Msg -> Model -> Model
update msg model =
  case msg of
    Type x  -> { model |  pathString = clean x }
    Left    -> model
    Right   -> model
    Up      -> model
    Down    -> model
    Restart -> model

-- do not explicitly say 92
next : (Int, Int) -> List String -> (Int, Int)
next (a,b) seq = case List.head seq of
  Just "L" -> (a-92,b)
  Just "R" -> (a+92,b)
  Just "U" -> (a,b-92)
  Just "D" -> (a,b+92)
  Just _   -> (a,b)
  Nothing  -> (a,b)

-- integrate the line segments
-- needs significant clean-up
-- needs to check for self-intersection
-- check for outside boundary
-- somewhat opinionated guide you into safe spaces
f : (Int, Int) -> List String -> List (Int, Int)
f pt seq = case List.tail seq of
  Just seq1  -> [ pt ] ++  ( f (next pt seq) seq1 )
  Nothing -> [ pt ]

calculatePath : (Int, Int) -> String -> List (Int, Int)
calculatePath x str = f x <| String.split "" str

writePath : List (Int, Int) -> String
writePath x = String.join " " <| List.map (\(a,b) -> (toString a) ++ "," ++ (toString b)) x

dx : Int -> Int
dx x = 20 + 46 + 92*x

dy : Int -> Int
dy y = 20 + 46 + 92*y

toCircle : (Int, Int) -> Svg Msg
toCircle (a,b) = circle
      [ cx <| toString <| dx <| a
      , cy <| toString <| dy <| b
      , r <| toString 10, stroke "none"
      , fill "#E8D62A" ] []

toPath : (Int, Int) -> String -> Svg Msg
toPath x str = g [] [ polyline [ strokeWidth "3", stroke "#E8D62A", points <| writePath <| calculatePath x str, fill "none"] [] ]

view: Model -> Html Msg
view model =
  div [style [("padding-left", "5px")]]
    [ h1 [ style [("font-family", "Helvetica")] ]
      [ div [ style [("width", "300"), ("display", "inline-block")] ] [ text "space-filling curves" ]
      , div [ style [("width", "200"), ("display", "inline-block")] ] [ textarea [ style [("width", "200"), ("float", "right")], onInput Type ] [ ] ]
      ]
    , div [  ] [ text  model.pathString ]
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
          <| List.map (\a -> line
            [ x1 (toString a)
            , x2 (toString a)
            , y1 (toString 20)
            , y2 (toString 480)
            , strokeWidth "1"
            , stroke "#3CE875"  ] [] )
          <| List.map (\x -> x)
          <| List.map (\x -> 20 + 92*x ) [1,2,3,4]
      , g []
          <| List.map (\a -> line
            [ x1 (toString 20)
            , x2 (toString 480)
            , y1 (toString a)
            , y2 (toString a)
            , strokeWidth "1"
            , stroke "#3CE875"  ] [] )
          <| List.map (\x -> x)
          <| List.map (\x -> 20 + 92*x  ) [1,2,3,4]
      , toCircle  model.start
      , toCircle model.end
      , toPath ( (\(a,b) -> (dx a, dy b)) model.start ) model.pathString
      ]
    ]
