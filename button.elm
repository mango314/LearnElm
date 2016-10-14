import Html exposing (div, span, button, text, Attribute, img, Html)
import Html.App exposing (program)
import Html.Events exposing (onClick, onMouseOver)
import Html.Attributes exposing (style, src, width)
import Mouse exposing (Position)


main =
  program { init = init, view = view, update = update, subscriptions = subscriptions}

-- Elm does not save us from CSS it only makes it more manageable
-- https://developer.mozilla.org/en-US/docs/Web/CSS/display
-- https://developer.mozilla.org/en-US/docs/Web/CSS/float

subscriptions: Model -> Sub Msg
subscriptions model = Mouse.moves MouseLocation

type alias Model = { n: Int, x: Int, y: Int }

init : ( Model, Cmd Msg )
init = ( { n = 0, x = 0, y = 0 } , Cmd.none  )

buttonStyle : Attribute msg
buttonStyle = style [ ("width", "25px") ]

numStyle : Attribute msg
numStyle = style [ ("width", "25px"), ("float", "left"), ("text-align", "center")]

view: Model -> Html Msg
view model =

  div [ width 500 ] [
    div [  ]
      [ button [ onClick Decrement, buttonStyle, style [ ("float", "left") ] ] [ text "-" ]
      , span [ numStyle ] [ text (toString model.n) ]
      , button [ onClick Increment, buttonStyle ] [ text "+" ]
      , text <| "Mouse Location:" ++ " ( " ++ (toString model.x) ++ "," ++ (toString model.y) ++ " )"
      ] ,
    div [  ] [img [ src "starry-night.jpg", width 500 ] [] ]
    ]

type Msg = Increment | Decrement | MouseLocation Position


-- our example could be read mouse locaation (over image) and return color of pixel at mouse location

update: Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    Increment ->
      ( { x = model.x, y = model.y, n = model.n + 1 }, Cmd.none)
    Decrement ->
      ( { x = model.x, y = model.y, n = model.n - 1 }, Cmd.none)
    MouseLocation pt->
      ( model, Cmd.none )
