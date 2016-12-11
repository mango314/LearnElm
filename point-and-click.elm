import Html exposing ( Html, button, div)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style)
import Svg exposing ( Svg, Attribute , svg, rect, circle )
import Svg.Attributes exposing ( width, height, viewBox, x, y, fill, stroke, strokeWidth, cx, cy, r)
import Svg.Events exposing (onMouseUp, onMouseDown )
import Mouse exposing (Position)

main = Html.program { init = init  , view = view, update = update , subscriptions = subscriptions}

init : (Model, Cmd Msg)
init = ( Model (2,3) False , Cmd.none )

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

type Msg = Click | Drag
type alias Model = { current : (Int, Int), showNeighbor : Bool }

update msg model =
  case msg of
    Click -> ({ model | showNeighbor = True  }, Cmd.none )
    Drag  -> ({ model | showNeighbor = False }, Cmd.none )

view : Model -> Html Msg
view model =
  if model.showNeighbor == True then
    svg [ width "500", height "500", viewBox "0 0 500 500" , style [ ("margin-left", "25px"), ("margin-top", "25px")]] <| [ board ] ++ checkerBoard ++ [ checker model ] ++ ( neighbors model )
  else
    svg [ width "500", height "500", viewBox "0 0 500 500" , style [ ("margin-left", "25px"), ("margin-top", "25px")]] <| [ board ] ++ checkerBoard ++ [ checker model ]

board: Html Msg
board = rect [ x "0", y "0", width "500", height "500", fill "#E4F2E1" ] []

checkerBoard : List ( Html Msg )
checkerBoard = List.map sq <| List.concat <| List.map (\y -> List.map (\x -> (x, y) ) <| List.range 0 8 )<| List.range 0 8

checker : Model -> Html Msg
checker model = let (a,b) = model.current in
  circle [ cx <| toString <| 50*(a+1), cy <| toString <| 50*(b+1), r "20", fill "#EB9C99", stroke "#000000", strokeWidth "2", onMouseUp Click] []

neighbors : Model -> List ( Html Msg )
neighbors model = let
  (a,b) = model.current
  nbr = [(a+2,b+1),(a-2,b+1),(a+2,b-1),(a-2,b-1),(a+1,b+2),(a-1,b+2),(a+1,b-2),(a-1,b-2)] in
  List.map chk nbr

chk : (Int, Int) -> Html Msg
chk (a,b) = circle [ cx <| toString <| 50*(a+1), cy <| toString <| 50*(b+1), r "20", fill "#F0F0F0", stroke "#000000", strokeWidth "2"] []

sq : (Int, Int) -> Html Msg
sq (a,b) = case (a+b) % 2 of
  0 -> rect [ x <| toString <| 50*a + 25 , y <| toString <| 50*b + 25, width "50", height "50", fill "#000000" ] []
  1 -> rect [ x <| toString <| 50*a + 25 , y <| toString <| 50*b + 25, width "50", height "50", fill "#F0F0F0" ] []
  _ -> rect [ x <| toString <| 50*a + 25 , y <| toString <| 50*b + 25, width "50", height "50" ] []
