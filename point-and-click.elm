import Html exposing ( Html, button, div)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style)
import Svg exposing ( Svg, Attribute , svg, rect, circle, polyline )
import Svg.Attributes exposing ( width, height, viewBox, x, y, fill, stroke, strokeWidth, cx, cy, r, points)
import Svg.Events exposing (onMouseUp, onMouseDown )
import Mouse exposing (Position)

main = Html.program { init = init  , view = view, update = update , subscriptions = subscriptions}

init : (Model, Cmd Msg)
init = ( Model (2,3) False [(2,3)], Cmd.none )

subscriptions : Model -> Sub Msg
subscriptions model =
  -- Mouse.ups Drag
  Sub.none

type Msg = Click | Drag (Int, Int)
type alias Model = { current : (Int, Int), showNeighbor : Bool, history: List (Int, Int) }

update msg model =
  case msg of
    Click  ->
      if model.showNeighbor == True then
        ({ model | showNeighbor = False  }, Cmd.none )
      else
        ({ model | showNeighbor = True   }, Cmd.none )
    Drag x ->
      if List.member x (nbr model.current) then
        ( Model x False (model.history ++ [x] ), Cmd.none )
      else
        (model, Cmd.none)

basicDisplay : Model -> List (Html Msg) -> Html Msg
basicDisplay model items = svg [ width "500", height "500", viewBox "0 0 500 500" , style [ ("margin-left", "25px"), ("margin-top", "25px")]] <| [ board ] ++ checkerBoard ++ [ checker model ] ++ items

f : List (Int, Int) -> String
f x = String.concat <| List.concat <| List.intersperse [" "] <| List.map ( \(a,b) -> [toString (50*(a+1)), "," , toString (50*(b+1))] ) x

historyPath : Model -> Svg Msg
historyPath ({current, showNeighbor, history} as model) =  polyline [ points <| f history, stroke "#B5B070", strokeWidth "4", fill "none" ] []

view : Model -> Html Msg
view model =
  if model.showNeighbor == True then
      basicDisplay model <| ( neighbors model ) ++ [ historyPath model ]
  else
      basicDisplay model []

board: Html Msg
board = rect [ x "0", y "0", width "500", height "500", fill "#E4F2E1" ] []

checkerBoard : List ( Html Msg )
checkerBoard = List.map sq <| List.concat <| List.map (\y -> List.map (\x -> (x, y) ) <| List.range 0 8 )<| List.range 0 8

shape : (Int, Int) -> List (Attribute Msg)
shape (a,b) = [ cx <| toString <| 50*(a+1), cy <| toString <| 50*(b+1), r "20", fill "#EB9C99", strokeWidth "2"]

checker : Model -> Html Msg
checker model = circle ( (shape model.current) ++ [ stroke "#000000", onMouseDown Click] ) []

nbr : (Int, Int) -> List (Int, Int)
nbr (a,b) = List.filter ( \(m,n) -> (m > -1) &&(n > -1) && (m < 9) && (n < 9) ) [(a+2,b+1),(a-2,b+1),(a+2,b-1),(a-2,b-1),(a+1,b+2),(a-1,b+2),(a+1,b-2),(a-1,b-2)]

neighbors : Model -> List ( Html Msg )
neighbors model = List.map chk <| nbr model.current

chk : (Int, Int) -> Html Msg
chk (a,b) = circle [ cx <| toString <| 50*(a+1), cy <| toString <| 50*(b+1), r "20", fill "#F0F0F0", stroke "#000000", strokeWidth "2"] []

sqShape : (Int, Int) -> List (Attribute Msg)
sqShape (a,b) = [ x <| toString <| 50*a + 25 , y <| toString <| 50*b + 25, width "50", height "50", onMouseUp <| Drag (a,b)]

sq : (Int, Int) -> Html Msg
sq (a,b) = case (a+b) % 2 of
  0 -> rect (sqShape (a,b) ++ [ fill "#000000" ] ) []
  1 -> rect (sqShape (a,b) ++ [ fill "#F0F0F0" ] ) []
  _ -> rect (sqShape (a,b)) []
