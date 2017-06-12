import Html exposing (Html, button, div, text, p)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style)
import Svg exposing (Svg, svg)
import Time exposing (Time, second)


-- example of time

main = Html.program { init = init, view = view, update = update, subscriptions = subscriptions}


-- init

type alias Model = Time

init : (Model, Cmd Msg)
init = (0, Cmd.none)

-- UPDATE

type Msg = Increment | Decrement | Tick Time

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Increment     ->    ( model + 1 , Cmd.none)

    Decrement     ->    ( model - 1 , Cmd.none)

    Tick newTime  ->    ( model + 1   , Cmd.none)


-- VIEW

blinking : Html.Attribute Msg
blinking = style [ ]

row : Html.Attribute Msg
row = style [("display", "inline-block"), ("width", "25px")]

info : Html.Attribute Msg
info = style [("width", "300px")]

view : Model -> Html Msg
view model =
  div [ style[("font-family", "Courier"), ("margin", "10px") ] ]
    [ div [ row ] [ button [ onClick Decrement ] [ text "-" ] ]
    , div [ row , style [("text-align", "center")] ] [ text (toString model) ]
    , div [ row ] [ button [ onClick Increment ] [ text "+" ] ]
    , div [ info ] [ p [] [ text "Rules: Click on the + button to increment, click on the - button to decrement." ] ]
    ]

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model = Time.every second Tick
