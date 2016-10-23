port module VanGogh exposing (..)

import Html exposing (div, span, button, text, Attribute, img, Html)
import Html.App exposing (program)
import Html.Events exposing (onClick, onMouseOver, onMouseOut)
import Html.Attributes as Html exposing (style, src, width, height)
import Mouse exposing (Position)

import Svg exposing (rect, svg)
import Svg.Attributes as Svg exposing (width, height, viewBox, x, y)


main =
  program { init = init, view = view, update = update, subscriptions = subscriptions}

-- Elm does not save us from CSS it only makes it more manageable
-- https://developer.mozilla.org/en-US/docs/Web/CSS/display
-- https://developer.mozilla.org/en-US/docs/Web/CSS/float

subscriptions: Model -> Sub Msg
subscriptions model = Sub.batch [ Mouse.moves MouseLocation, getImageData GetImage  ]

type alias Model = { n: Int, x: Int, y: Int, p: Bool, img: List Int }

init : ( Model, Cmd Msg )
init = ( { n = 0, x = 0, y = 0, p= False , img = []} , Cmd.none  )

buttonStyle : Attribute msg
buttonStyle = style [ ("width", "25px"), ("display", "inline-block") ]

numStyle : Attribute msg
numStyle = style [ ("width", "25px"),("display", "inline-block"), ("text-align", "center")]

display : Model -> Html Msg
display model =
  if model.p
    then text <| "Mouse Location:" ++ " ( " ++ (toString model.x) ++ "," ++ (toString model.y) ++ " )"
  else
    text <| "Mouse Location:" ++ " -------- "

-- idiosyncracy
-- Svg.width  : String -> Attribute Msg
-- Html.width : Int    -> Attribute Msg

square: Model -> Html Msg
square model = svg [ Svg.width "20", Svg.height "20", Svg.viewBox "0 0 20 20"] [
  rect [ Svg.x "0", Svg.y "0", Svg.width "20", Svg.height "20" ] [] ]

view: Model -> Html Msg
view model =

  div [ Html.width 500 ] [
    div [   ]
      [ button [ onClick Decrement, buttonStyle ] [ text "-" ]
      , span [ numStyle ] [ text (toString model.n) ]
      , button [ onClick Increment, buttonStyle ] [ text "+" ]
      , div [ style [ ("width", "200px"), ("text-align", "center"), ("display", "inline-block")] ] [ display model ]
      , div [ style [ ("width", "125px"), ("text-align", "center"), ("display", "inline-block")] ] [text <| "Mouse Over: " ++ (toString model.p) ]
--      , div [ style [ ("width", "125px"), ("text-align", "center"), ("display", "inline-block")] ] [text <| "Picture: " ++ (toString model.img) ]
      , div [ style [ ("width", "125px"), ("text-align", "center"), ("display", "inline-block")] ] [ square model ]
      , button [onClick CheckImage ] [ text "pixelate"]
      ] ,
    div [ Html.width 500, style [ ("float", "left")]  ] [img [ src "starry-night.jpg", Html.width 500, Html.height 300,  onMouseOver ShowLocation, onMouseOut HideLocation] [] ]
    ]

type Msg = Increment | Decrement | MouseLocation Position | ShowLocation | HideLocation | CheckImage | GetImage ( List Int )

--showLocation =
--  case msg of


-- our example could be read mouse locaation (over image) and return color of pixel at mouse location

update: Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    Increment ->
      ( {model | n = model.n + 1 } , Cmd.none)
    Decrement ->
      ( {model | n = model.n - 1 }, Cmd.none)
    MouseLocation pt->
      ( {model| x = pt.x, y = pt.y} , Cmd.none )
    ShowLocation ->
      ( {model | p  = True } , Cmd.none)
    HideLocation ->
      ( {model | p = False } , Cmd.none)
    CheckImage ->
      ( model, checkImageData "starry-night.jpg" )
    GetImage x ->
      ( {model | img = x  }, Cmd.none )

port checkImageData : String -> Cmd msg

port getImageData: (List Int -> msg ) -> Sub msg
