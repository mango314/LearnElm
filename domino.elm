-- homework: remove all the repetetive parts using functoriality!
import Html exposing (Html, button, div, text, p)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style)
import Svg exposing (Svg, svg, polygon, polyline, line )
import Svg.Attributes exposing (points, stroke, strokeWidth, fill, x1, x2, y1, y2)

main =
  Html.beginnerProgram { model = 0, view = view, update = update }

type Msg = Increment | Decrement

update msg model =
  case msg of
    Increment ->
      model + 1

    Decrement ->
      model - 1

-- this could be made even more functional, but notice the use of
--  (>>)
--  <function> : (a -> b) -> (b -> c) -> a -> c
--  (<<)
--  <function> : (b -> c) -> (a -> b) -> a -> c

center = ((\a -> a + 150), (\b -> b + 150))
(f,g ) = ((\a -> a + 10), (\b -> b + 10))

aztecDiamondBoundaryData dx dy =
  let
    x = List.map ( (Tuple.first  center)  << (\t -> dx*t) ) [0,1,1,2,2,3,3,4,4,5,5]
    y = List.map ( (Tuple.second center)  << (\t -> dy*t) ) [5,5,4,4,3,3,2,2,1,1,0]
    z = List.map2 (,) x y
  in
    String.join ", " <<  List.map (\ (a,b) -> toString a ++ ", " ++ toString b ) <| z

aztecDiamondLines dx dy =
  let
    a = List.map (\t -> line [ x1 ( toString <| f 0*dx ), x2 ( toString <| f (5-t)*dx ), y1 ( toString  <| g  t*dy ), y2 ( toString <| g    t*dy ) , stroke "black", fill "none"] [] ) [0,1,2,3,4,5]
    b = List.map (\t -> line [ x1 ( toString <| f 0*dx ), x2 ( toString <| f (5-t)*dx ), y1 ( toString <| g (-1*t)*dy ), y2 ( toString <| g (-1*t)*dy ) , stroke "black", fill "none"] [] ) [0,1,2,3,4,5]
    c = List.map (\t -> line [ x1 ( toString  <| f  t*dx ), x2 ( toString  <| f  t*dx ), y1 ( toString <| g 0*dy ), y2 ( toString <| g (5-t)*dy ) , stroke "black", fill "none"] [] ) [0,1,2,3,4,5]
    d = List.map (\t -> line [ x1 ( toString <| f (-1*t)*dx ), x2 ( toString <| f (-1*t)*dx ), y1 ( toString <| g 0*dy ), y2 ( toString <| g (5-t)*dy ), stroke "black" , fill "none"] [] ) [0,1,2,3,4,5]
  in
    a ++ b ++ c ++ d

view model =
  div [ style [("margin-left", "5px") ]]
    [ p [ style [("font-family", "Helvetica"), ("width", "400")] ] [ text "Click on a vertex to switch between horizontal and vertical squares." ]
    , svg [ style [("width", "300"), ("height", "300"), ("background-color", "#F0F0F0"), ("margin", "1px") ] ]
    <|  [ polyline [ points <| aztecDiamondBoundaryData  15  15 , stroke "black", strokeWidth "2", fill "none" ] []
        , polyline [ points <| aztecDiamondBoundaryData -15  15 , stroke "black", strokeWidth "2", fill "none" ] []
        , polyline [ points <| aztecDiamondBoundaryData  15 -15 , stroke "black", strokeWidth "2", fill "none" ] []
        , polyline [ points <| aztecDiamondBoundaryData -15 -15 , stroke "black", strokeWidth "2", fill "none" ] []
        ] ++ (aztecDiamondLines 15 15)
    ]
