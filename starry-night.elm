port module VanGogh exposing (..)

import Html exposing (div, span, button, text, Attribute, img, Html)
import Html.App exposing (program)
import Html.Events exposing (onClick, onMouseOver, onMouseOut)
import Html.Attributes exposing (style, src, width)
import Mouse exposing (Position)


main =
  program { init = init, view = view, update = update, subscriptions = subscriptions}

-- Elm does not save us from CSS it only makes it more manageable
-- https://developer.mozilla.org/en-US/docs/Web/CSS/display
-- https://developer.mozilla.org/en-US/docs/Web/CSS/float

subscriptions: Model -> Sub Msg
subscriptions model = Mouse.moves MouseLocation

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


view: Model -> Html Msg
view model =

  div [ width 500 ] [
    div [ width 500  ]
      [ button [ onClick Decrement, buttonStyle ] [ text "-" ]
      , span [ numStyle ] [ text (toString model.n) ]
      , button [ onClick Increment, buttonStyle ] [ text "+" ]
      , div [ style [ ("width", "200px"), ("text-align", "center"), ("display", "inline-block")] ] [ display model ]
      , div [ style [ ("width", "200px"), ("text-align", "center"), ("display", "inline-block")] ] [text <| "Mouse Over: " ++ (toString model.p) ]
      , span [ width 100] [ text "."]
      ] ,
    div [ width 500, style [ ("float", "left")]  ] [img [ src "starry-night.jpg", width 500, onMouseOver ShowLocation, onMouseOut HideLocation] [] ]
    ]

type Msg = Increment | Decrement | MouseLocation Position | ShowLocation | HideLocation

--showLocation =
--  case msg of


-- our example could be read mouse locaation (over image) and return color of pixel at mouse location

update: Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    Increment ->
      ( { x = model.x, y = model.y, n = model.n + 1, p = model.p, img= model.img }, Cmd.none)
    Decrement ->
      ( { x = model.x, y = model.y, n = model.n - 1, p = model.p , img= model.img}, Cmd.none)
    MouseLocation pt->
      ( { x = pt.x, y = pt.y, n = model.n, p = model.p , img= model.img}, Cmd.none )
    ShowLocation ->
      ( { x = model.x, y = model.y, n = model.n , p = True , img= model.img} , Cmd.none)
    HideLocation ->
      ( { x = model.x, y = model.y, n = model.n , p = False, img= model.img } , Cmd.none)

port checkImageData : String -> Cmd msg

port getImageData: (List Int -> msg ) -> Sub msg
