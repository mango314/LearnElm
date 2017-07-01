import Html exposing (Html, Attribute, button, div, text, h2)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Time exposing (Time, second)



main =
  Html.program { init = init , view = view, update = update, subscriptions = subscriptions }

type Msg = Tick Time | Cycle

type alias Model = Int

init : (Model, Cmd Msg)
init = (0, Cmd.none)

update: Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of

    Tick x -> (model + 1 , Cmd.none)

    Cycle -> (model, Cmd.none)

panelStyle : Int -> Int -> Attribute Msg
panelStyle model t = style
  [ ("width", "100px")
  , ("background-color", "#A0A0A0")
  , ("margin", "5px")
  , ("padding", "1px")
  , ("overflow", ("hidden"))
  , case ( model % (20*5) ) == t  of
      True -> ("visibility", "hidden")
      False -> ("visibility", "visible")
  ]

moment : Model -> List (Int, (String, Int))
moment model =
  ( List.take  ( min (model % 100 ) 10 )          <| List.drop ( 10*((model//100) % 3 ) ) <| List.map2 (,) (List.range 0 48) cities )
  ++ ( List.take  ( max ( 10 - ( model % 100 ) ) 0 ) <| List.drop (( 10*((model//100) % 3 ) )  + (( min (model % 100 ) 10 )  )) <| List.map2 (,) (List.range 0 48) cities )


row : (String , Int) -> Html Msg
row (a,b) = text a

view: Model -> Html Msg
view model =
  div []
    [ h2 []
      [ text "TIMETABL"
--      , text <|  toString  <| min (model % 100 ) 10
--      , text "+"
--      , text <|  toString  <| max ( 10 - ( model % 100 ) ) 0
--      , text "="
--      , text <|  toString  <| (min (model % 100 ) 10) + (max ( 10 - ( model % 100 ) ) 0)
      ]
    , div []
      <| List.map (\(a,x) -> div [ panelStyle model a ] [ row x ] )
      <| moment model
      ]

subscriptions : Model -> Sub Msg
subscriptions model = Time.every (0.1*second) Tick

-- DATA


-- unpredictible, random, informative, tedious
-- computed by hand, one by one

cities : List (String, Int)
cities = [ ("Accra" ,     -1 )
  , ("Casablanca"           , -1)
  , ("Kolkata"             , 5)
  ,("Reykjavik"           , -1)
  ,("Chicago"              , -6)
  ,("Kuala Lumpur"      , 7)
  ,("Addis Ababa"         , 2)
  ,("Rio de Janeiro"      , -4)
  ,("Adelaide"            , 8)
  ,("Copenhagen"          , 1)
  ,("Kuwait City"       , 2)
  ,("Riyadh"              , 2)
  ,("Algiers"             , 0)
  ,("Dallas"               , -6)
  ,("Kyev"               , 2)
  ,("Rome"                , 1)
  ,("Almaty"             , 5)
  ,("Dar es Salaam"     , 2)
  ,("La Paz"              , -5)
  ,("Salt Lake City"    , -7)
  ,("Amman"              , 2)
  ,("Darwin"              , 9)
  ,("Lagos"              , 0)
  ,("San Francisco"      , 4)
  ,("Amsterdam"          , 1)
  ,("Denver"              , -9)
  ,("Lahore"          , -8)
  ,("San Juan"            , -5)
  ,("Anadyr"              , 11)
  ,("Detroit"             , -5)
  ,("Las Vegas"          , -8)
  ,("San Salvador"        , -7)
  ,("Anchorage"          , -9)
  ,("Dhaka"             , -7)
  ,("Lima"                 , -6)
  ,("Santiago"          , -5)
  ,("Ankara"             , 2)
  ,("Doha"              , 2)
  ,("Lisbon"             , 0)
  ,("Santo Domingo"      , -5)
  ,("Antananarivo"        , 2)
  ,("Dubai"              , 3)
  ,("London"            , 0)
  ,("São Paulo"           , -4)
  ,("Asuncion"         , -5)
  ,("Dublin"             , 0)
  ,("Los Angeles"       , 4)
  ,("Seattle "          , 4)
  ]
