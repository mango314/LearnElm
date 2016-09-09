import Html exposing (Html, button, div, text, span)
import Html.App as App
import Html.Events exposing (onClick)
import Html.Attributes as Attribute exposing ( style)

main =
  App.beginnerProgram { model = 0, view = view, update = update }

type Msg = Increment | Decrement

update msg model =
  case msg of
    Increment ->
      model + 1

    Decrement ->
      model - 1

view model =
  div []
    [ button [ onClick Decrement , myStyle] [ text "-" ]
    , div [ myStyle ] [ text (toString model) ]
    , button [ onClick Increment, myStyle ] [ text "+" ]
    ]

myStyle : Html.Attribute msg
myStyle = style [ ( "width", "25px"  ), ("background-color", "#FFE1C0"), ("float", "left"), ("text-align", "center")]
