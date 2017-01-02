-- Candy Crush Saga prototype

import Html exposing (Html, div, button, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
-- import Svg exposing (..)
-- import Svg.Attributes exposing (..)
-- import Time exposing (Time, second, millisecond)

main = Html.program {
  init = init,
  view = view,
  update = update,
  subscriptions = subscriptions
  }

type alias Model = { stack: List Int }

init : (Model, Cmd Msg)
init = ( Model (List.map (\x -> 0) <| List.range 0 7) , Cmd.none )

type Msg = Drop Int

update : Msg -> Model -> (Model, Cmd Msg)
update msg model  =
  case msg of
      Drop x ->
        case List.head ( List.drop x model.stack ) of
          Just a  -> ( Model <| (List.take x model.stack ) ++ [a+1]  ++ (List.drop (x+1) model.stack ) , Cmd.none)
          Nothing -> ( Model <| (List.take x model.stack ) ++ [0]    ++ (List.drop (x+1) model.stack ) , Cmd.none)

f : Int -> Html Msg
f x = div [ style [("width", "25px"),("display", "inline-block")] ] [ button [ onClick <| Drop (x-1)  ] [ text (toString x) ] ]

g : Int -> Html Msg
g x = div [ style [("width", "25px"), ("display", "inline-block"), ("text-align", "center")] ] [ text ( toString x )]

view : Model -> Html Msg
view model =
  div []
  [ div [] <| List.map g model.stack
  , div [] <| List.map f <| List.range 1 8
  ]


subscriptions : Model -> Sub Msg
subscriptions model = Sub.none
