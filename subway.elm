import Html exposing ( Html, button, div, text, h2, span)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style)
import Svg exposing (Svg, svg, rect, circle, text_)
import Svg.Attributes exposing (height, width, viewBox,x,y, width, height, fill, cx, cy, r, fontFamily)

main = Html.beginnerProgram { model = 0, view = view, update = update }

type Msg = Increment | Decrement

update msg model =
  case msg of
    Increment -> model + 1
    Decrement -> model - 1

-- http://web.mta.info/developers/resources/line_colors.htm
dTrainColor : String
dTrainColor = "#FF6319"

view : Int -> Html Msg
view model =
  div []
    [ div [ style [("backgroundColor", "#EEEEEE" ), ("width", "500px"), ("height", "36pt"), ("text-align", "center") ]]
      [ h2 [ style [("font-family", "Helvetica"), ("line-height", "36pt")]] [ text "Subway Stations of New York ", span [ style [("color", dTrainColor )]] [ text "D"], text " Line"]
      ]
    , svg [ width "500", height "1200", viewBox "0 0 500 1200"] <|
      [ rect [ x "10", y "10", width "10", height "1200", fill "#FF6319" ] []
      ] ++ trainStations
    ]

f : (Int , String) -> List ( Svg Msg )
f ( yt ,station ) = [ circle [ cx "15", cy (toString   yt ), r "4", fill "#000000"] [] , text_ [ fontFamily "Helvetica", x "45", y (toString <|   yt + 5)] [ text station ] ]

stations : List String
stations = [ "205 St"
  ,  "Bedford Park Blvd"
  , "Kingsbridge Rd"
  , "Fordham Rd"
  , "182-183 Sts"
  ,  "Tremont Ave"
  , "174-175 St"
  , "170 St"
  ,  "167 St"
  ,   "161 St - Yankee Stadium"
  , "155 St",      "145 St"
  ,  "125 St" ,  "59 St - Columbus Circle" ,  "7 Avenue",  "47-50 Sts - Rockefeller Center" ,  "42 St - Bryant Park"
  ,  "34 St - Herald Sq" ,   "W 4 St - Washington Square" , "Broadway-Lafayette St / Bleeker St" ,  "Grand St" ,    "Dekalb Ave"
  ,  "Atlantic Ave / Barclays Center",   "Union St",     "9 St",    "Prospect Ave",   "25 St",    "36 St",  "9 Ave"
  ,  "Fort Hamilton Parkway" ,     "50 St" ,    "55 St",    "62 St" , "71 St",   "18 Ave" ,   "20 Ave", "Bay Parkway" ,  "25 Ave"
  ,  "Bay 50 St" , "Coney Island - Stillwell Ave"
  ]


trainStations : List ( Html Msg )
trainStations =
  List.concat <| List.map f <| List.map2 (,) ( List.map (\x -> 30*x + 20) <| List.range 0 40 )  stations
