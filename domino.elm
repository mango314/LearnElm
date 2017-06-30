-- homework: remove all the repetetive parts using functoriality!
import Html exposing (Html, button, div, text, p)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style)
import Svg exposing (Svg, svg, polygon, polyline, line, g, rect, circle )
import Svg.Attributes exposing (points, stroke, strokeWidth, fill, x1, x2, y1, y2, width, height, cx, cy, r, opacity)
import Svg.Events exposing (onMouseOver, onMouseOut)
import Dict exposing (..)

-- idea:
--
-- implement domino tiling as a data structure over a dictionary.
-- if every square can be referred to by a pair of integers maybe
--

main =
  Html.beginnerProgram
    { model =
      {   color = Dict.fromList
      <|  List.map (\x -> (x,"0"))
      <| product (List.range 1 4) (List.range 1 4)
      ,   matching = Dict.empty
      }
    , view = view
    , update = update
    }

type Msg = Hover (Int, Int) | Leave (Int, Int) | Click (Int, Int)

update msg model =
  case msg of
    Hover x -> { model | color = Dict.update x (\ y -> Just "1" ) model.color }
    Leave x -> { model | color = Dict.update x (\ y -> Just "0" ) model.color }
    Click x -> model


domino : (Int, Int) -> Int -> Svg Msg
domino (a,b) x =
  case x  of
    0   -> tile <| (\(x,y) -> [(x,y), (x+1,y),(x+2,y),(x+2,y+1),(x+1,y+1),(x,y+1),(x,y)] ) (a,b)
    1   -> tile <| (\(x,y) -> [(x,y), (x+1,y),(x+1,y+1),(x+1,y+2),(x,y+2),(x,y+1),(x,y)] ) (a,b)
    _   -> tile []

tile : List (Int, Int) -> Svg Msg
tile x = polygon
  [ points
  <| String.join " "
  <| List.map ((\ (a,b) -> toString a ++ "," ++ toString b) <<  (\(a,b) -> (a+20, b+20)) << (\(a,b) -> (92*a , 92*b) ) ) x
  , stroke "#707070"
  , fill "none"
  , strokeWidth "3"
  ]
  []

--domino :: (Int, Int) -> (Int, Int) -> Maybe
--domino (a,b) (c,d) = case

product x y = List.concat <| List.map (\b -> List.map (\a -> (a,b)) <| x ) <| y


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
          , domino (0,0) 0
          , domino (2,0) 1
          , domino (3,0) 0
          , domino (3,1) 1
          , domino (4,1) 1
          , domino (3,3) 0
          , domino (3,4) 0
          , domino (0,1) 1
          , domino (1,1) 1
          , domino (0,3) 0
          , domino (1,4) 0
          , g []
            <| List.map
              ( (\(a,b) -> circle
                [ cx (toString a)
                , cy (toString b)
                , r "5"
                , fill "#404040"
                , opacity <|
                    case get (a,b) model.color of
                      Just x -> x
                      Nothing -> "0"
                , onMouseOver   <| Hover (a,b)
                , onMouseOut    <| Leave (a,b)
  --              , onDoubleClick <| Click (a,b)
                ] [] )
              << (\(a,b) -> (a+20, b+20) )
              << (\(a,b) -> (a*92, b*92) )
              )
            <| product (List.range 1 4) (List.range 1 4)
          ]
      ]
    ]
