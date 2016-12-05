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

f : Int -> String -> List ( Svg Msg )
f yt station = [ circle [ cx "15", cy (toString   yt ), r "4", fill "#000000"] [] , text_ [ fontFamily "Helvetica", x "45", y (toString <|   yt + 5)] [ text station ] ]


trainStations : List ( Html Msg )
trainStations =
  (f   20 "205 St" ) ++
  (f   50 "Bedford Park Blvd" ) ++
  (f   80 "Kingsbridge Rd" ) ++
  (f 110  "Fordham Rd" ) ++
  (f 140 "182-183 Sts" ) ++
  (f 170 "Tremont Ave" ) ++
  (f 200  "174-175 St" ) ++
  (f 230 "170 St" ) ++
  (f 260  "167 St" )
  (f  290  "161 St - Yankee Stadium" ) ++
  (f  320    "155 St" ) ++
  (f  350     "145 St" ) ++
  (f  380     "125 St" ) ++
  (f  410     "59 St - Columbus Circle" ) ++
  (f  440     "7 Avenue" ) ++
  (f  470     "47-50 Sts - Rockefeller Center" ) ++
  (f  500     "42 St - Bryant Park" ) ++
  (f  530     "34 St - Herald Sq" ) ++
  (f  560     "W 4 St - Washington Square" ) ++
  (f  590     "Broadway-Lafayette St / Bleeker St" ) ++
  (f  620     "Grand St" ) ++
  (f  650     "Dekalb Ave" ) ++
  (f  680     "Atlantic Ave / Barclays Center" ) ++
  (f  710     "Union St" ) ++
  (f  740     "9 St" ) ++
  (f  770     "Prospect Ave" ) ++
  (f  800     "25 St" ) ++
  (f  830     "36 St" ) ++
  (f  860     "9 Ave" ) ++
  (f  890     "Fort Hamilton Parkway" ) ++
  (f  920     "50 St" ) ++
  (f  950     "55 St" ) ++
  (f  980     "62 St" ) ++
  (f 1010    "71 St" ) ++
  (f 1040    "18 Ave" ) ++
  (f 1070    "20 Ave" ) ++
  (f 1100    "Bay Parkway" ) ++
  (f 1130   "25 Ave" ) ++
  (f 1160   "Bay 50 St" ) ++
  (f 1190    "Coney Island - Stillwell Ave" )
  ]
