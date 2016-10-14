import Html exposing (div, span, button, text, Attribute)
import Html.App exposing (beginnerProgram)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style)


main =
  beginnerProgram { model = 0, view = view, update = update }

-- Elm does not save us from CSS it only makes it more manageable
-- https://developer.mozilla.org/en-US/docs/Web/CSS/display
-- https://developer.mozilla.org/en-US/docs/Web/CSS/float

buttonStyle : Attribute msg
buttonStyle = style [ ("width", "25px"),("float", "left") ]

numStyle : Attribute msg
numStyle = style [ ("width", "25px"), ("float", "left"), ("text-align", "center")]

view model =
  div []
    [ button [ onClick Decrement, buttonStyle ] [ text "-" ]
    , span [ numStyle ] [ text (toString model) ]
    , button [ onClick Increment, buttonStyle ] [ text "+" ]
    ]


type Msg = Increment | Decrement


update msg model =
  case msg of
    Increment ->
      model + 1

    Decrement ->
      model - 1
