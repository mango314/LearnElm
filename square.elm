import Html exposing (..)
import Html.App as App
import Html.Attributes exposing ( .. )
import Svg exposing (..)
import Svg.Attributes exposing ( .. )
import Time exposing (Time, second)

main = App.program { init = init, view = view, subscriptions = subscriptions, update = update }

-- MODEL

type alias Model = Time

init : ( Model, Cmd Msg )
init = ( 0, Cmd.none )

-- UPDATE

type Msg = Tick Time

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    Tick newTime -> ( model + 1, Cmd.none )

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model = Time.every second Tick

-- VIEW

myStyle : Html.Attribute msg
myStyle = Html.Attributes.style
  [ ("backgroundColor" , "#F0F0F0")
  , ("width", "500px")
  ]

view : Model -> Html Msg
view model = div []
  [ p [ myStyle ] [Html.text <| toString model ]
  , Svg.svg [ Svg.Attributes.width "500",  Svg.Attributes.height "500" ]
    [
      -- https://developer.mozilla.org/en-US/docs/Web/SVG/Element/rect
      rect [ Svg.Attributes.x "0", Svg.Attributes.y "0", Svg.Attributes.width "500", Svg.Attributes.height "500" , Svg.Attributes.fill "#F0F0F0" ]  []
    , circle [ Svg.Attributes.cx "250", Svg.Attributes.cy "250", Svg.Attributes.r "250" , Svg.Attributes.fill "#DDDDFF"] []
    , circle [ Svg.Attributes.cx <| toString <| ( 250 + (125 + 62.5) * cos ( model / 10) )  , Svg.Attributes.cy <| toString <| ( 250 + (125 + 62.5)* sin ( model / 10) )      ,  Svg.Attributes.r "62.5" , Svg.Attributes.fill "#9999FF" ] []
    ]
  ]
