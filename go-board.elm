-- Elm v0.18
-- import Html.App as Ap
import Html exposing (Html, button, div, text, beginnerProgram)
import Html.Events exposing (onClick)

import Svg exposing (svg, rect, line, circle)
import Svg.Attributes exposing ( width, height, fill, stroke, x1, x2, y1, y2, strokeWidth, cx, cy, r)


main =
  beginnerProgram { model = 0, view = view, update = update }

type Msg = Increment | Decrement

update msg model =
  case msg of
    Increment ->
      model + 1

    Decrement ->
      model - 1

f a b =  line [ x1 (toString <| (a+1)*25 ), y1 (toString <| (b+1)*25  ), x2 (toString <| (a+19)*25 ), y2 (toString <| (b+ 1)*25 ), stroke "black" , strokeWidth "2" ] []

g a b =  line [ x1 (toString <| (a+1)*25 ), y1 (toString <| (b+1)*25  ), x2 (toString <| (a+ 1)*25 ), y2 (toString <| (b+19)*25 ), stroke "black" , strokeWidth "2" ] []

h (a, b) =  circle [ cx ( toString <| (a+1)*25 ) , cy (toString <| (b+1)*25) , r (toString 5) ] []

view model =
  div []
    [ div []
      [ text "Go Board"
      ]
    , div [] [ svg [ width "500", height "500" ] <|
        [ rect [ width "500", height "500", fill "#DCFFB4"] []
        ] ++
        ( List.map (\c -> f 0 c) <| List.range 0 18 ) ++
        ( List.map (\c -> g c 0) <| List.range 0 18 ) ++
        ( List.map h [ (3,3), (3,9), (3,15), (9,3), (9,9), (9,15), (15,3), (15,9), (15,15) ] )
      ]
    ]
