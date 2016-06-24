import Html exposing (..)
import Html.App as App
import Html.Attributes exposing ( .. )
import Svg exposing (..)
import Svg.Attributes exposing ( .. )
import Time exposing (Time, second)
import Color exposing (..)

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

-- number of circles
n : Int
n = 10

a : Float
a = 250

b : Float
b = (1 - sin ( 3.1415 / (toFloat n) ) ) / ( 1 + sin ( 3.1415 / (toFloat n) )  ) * a

c : Float
c = 0.5*(a - b)


type alias Circle = { cx: Float, cy: Float, r: Float, fill: String}

draw : Circle -> Svg msg
draw x = circle [ Svg.Attributes.cx <| toString x.cx , Svg.Attributes.cy <| toString x.cy , Svg.Attributes.r <| toString x.r , Svg.Attributes.fill x.fill ] []

type alias SteinerChain = List Circle

f : Float -> Circle
f x = Circle ( 250 + 0.5*(a+b) *  ( cos <| x  * 3.1415  ) ) ( 250 + 0.5*(a+b)* ( sin <| x * 3.1415   )  ) (0.5*(a-b) ) "#9999FF"

chain : Float -> SteinerChain
chain y = List.map f <| List.map ( \x ->  2 * (x / (toFloat n ) ) + (y/25) )  <| List.map toFloat [0..n]

myStyle : Html.Attribute msg
myStyle = Html.Attributes.style
  [ ("backgroundColor" , "#F0F0F0")
  , ("width", "500px")
  ]

view : Model -> Html Msg
view model = div []
  [ p [ myStyle ] [Html.text <| toString model ]
  , Svg.svg [ Svg.Attributes.width "500",  Svg.Attributes.height "500" ]
  <|  [
      -- https://developer.mozilla.org/en-US/docs/Web/SVG/Element/rect
      rect [ Svg.Attributes.x "0", Svg.Attributes.y "0", Svg.Attributes.width "500", Svg.Attributes.height "500" , Svg.Attributes.fill "#F0F0F0" ]  []
      , draw <| Circle 250 250 a "#AAFFAA"
      , draw <| Circle 250 250 b "#FFAAAA"
      -- , draw <| Circle ( 250 + 0.5*(a+b) *  ( cos <| model * 3.1415 / 10  ) ) ( 250 + 0.5*(a+b)* ( sin <| model * 3.1415 / 10  )  ) (0.5*(a-b) ) "#9999FF"
      ] ++  (List.map draw <| (chain model) )
  ]
