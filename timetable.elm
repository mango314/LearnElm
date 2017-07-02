import Html exposing (Html, Attribute, button, div, text, h2)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Time exposing (Time, second)
import Task exposing (..)



main =
  Html.program { init = init , view = view, update = update, subscriptions = subscriptions }

type Msg = Tick Time | NewTime Time

type alias Model = { count : Int , time : Time, hour : Int, minute : Int, second : Int }

init : (Model, Cmd Msg)
init = ( Model 0 0 0 0 0 , Cmd.none)

update: Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of

    Tick x -> ( {model | count = (model.count + 1)%(4*100) }, Task.perform NewTime Time.now )

    NewTime x ->  let
                    t = (\a -> a % (60*60*24) ) <| ( floor x ) // 1000
                  in
                    ( {model | time = x , hour = t // (60*60) , minute = (t // 60 ) % 60 , second = t % 60 } , Cmd.none)

panelStyle : Int -> Int -> Attribute Msg
panelStyle model t = style
  [ ("width", "125px")
  , ("background-color", "#B0B0B0")
  , ("margin", "5px")
  , ("padding", "1px")
  , ("overflow", ("hidden"))
  , case ( model   % 100 ) == t  of
      True  -> ("visibility", "hidden" )
      False -> ("visibility", "visible")
  ]

panelStyle2 : Int -> Int -> Attribute Msg
panelStyle2 model t = style
  [ ("width", "60px")
  , ("background-color", "#B0B0B0")
  , ("margin", "5px")
  , ("padding-right", "5px")
  , ("overflow", ("hidden"))
  , ("text-align", "right")
  , case ( model  % 100 ) == t  of
      True  -> ("visibility", "hidden" )
      False -> ("visibility", "visible")
  ]

moment : Int -> List (Int, (String, Int))
moment model =
  let
    c = 12*( model // 100 )
    shortList =  ( List.drop c ) cities
    a = min 12 (model % 100)
    b = max 0 (12 - (model % 100))
  in
    List.map2 (,) (List.range 0 12 )
    <| ( List.take a ( List.drop c  cities ) )
    ++ ( List.take b ( List.drop a ( List.drop (c-12)  cities ) ) )

row : Model  -> (String , Int) -> Html Msg
row  model (a,b) = text a

row1 : Model -> (String , Int) -> Html Msg
row1 model (a,b) =
  let
    mnt = case model.minute < 10 of
      True  -> "0" ++ ( toString model.minute )
      False ->  toString model.minute
    sec = case model.second < 10 of
      True  -> "0" ++ ( toString model.second )
      False ->  toString model.second
  in
    text <| ( toString <| ( b + model.hour ) % 24 ) ++ ":" ++ mnt ++ ":" ++ sec

view: Model -> Html Msg
view model =
  div [ style [("padding-left", "5px")] ]
    [ h2  []
      [ text "TIMETABL "
--      , text <| toString <| (\x -> x % (60*60*24) ) <| ( floor model.time) // 1000
      , text <| toString <| model.hour
      , text ":"
      , text <| toString <| model.minute
      , text ":"
      , text <| toString <| model.second
      ]
    , div []
      <| List.map (\(a,x) -> div []
          [ div [ panelStyle  model.count a, style [("display", "inline-block")] ] [ row  model x  ]
          , div [ panelStyle2 model.count a, style [("display", "inline-block")] ] [ row1 model x  ]
          ] )
      <| moment model.count
    ]

subscriptions : Model -> Sub Msg
subscriptions model = Time.every ( 0.1*second ) Tick

-- DATA
-- unpredictible, random, informative, tedious
-- computed by hand, one by one

cities : List (String, Int)
cities = [ ("Accra"       , -1)
  , ("Casablanca"         , -1)
  , ("Kolkata"            ,  5)
  , ("Reykjavik"          , -1)
  , ("Chicago"            , -6)
  , ("Kuala Lumpur"       ,  7)
  , ("Addis Ababa"        ,  2)
  , ("Rio de Janeiro"     , -4)
  , ("Adelaide"           ,  8)
  , ("Copenhagen"         ,  1)
  , ("Kuwait City"        ,  2)
  , ("Riyadh"             ,  2)
  , ("Algiers"            ,  0)
  , ("Dallas"             , -6)
  , ("Kyev"               ,  2)
  , ("Rome"               ,  1)
  , ("Almaty"             ,  5)
  , ("Dar es Salaam"      ,  2)
  , ("La Paz"             , -5)
  , ("Salt Lake City"     , -7)
  , ("Amman"              ,  2)
  , ("Darwin"             ,  9)
  , ("Lagos"              ,  0)
  , ("San Francisco"      ,  4)
  , ("Amsterdam"          ,  1)
  , ("Denver"             , -9)
  , ("Lahore"             , -8)
  , ("San Juan"           , -5)
  , ("Anadyr"             , 11)
  , ("Detroit"            , -5)
  , ("Las Vegas"          , -8)
  , ("San Salvador"       , -7)
  , ("Anchorage"          , -9)
  , ("Dhaka"              , -7)
  , ("Lima"               , -6)
  , ("Santiago"           , -5)
  , ("Ankara"             ,  2)
  , ("Doha"               ,  2)
  , ("Lisbon"             ,  0)
  , ("Santo Domingo"      , -5)
  , ("Antananarivo"       ,  2)
  , ("Dubai"              ,  3)
  , ("London"             ,  0)
  , ("São Paulo"          , -4)
  , ("Asuncion"           , -5)
  , ("Dublin"             ,  0)
  , ("Los Angeles"        ,  4)
  , ("Seattle "           ,  4)
  ]
