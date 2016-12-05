import Html exposing ( Html, button, div, text, h3, span)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style)
import Svg exposing (svg, rect, circle, text_)
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

view model =
  div []
    [ div [ style [("backgroundColor", "#EEEEEE" ), ("width", "500px"), ("height", "36pt"), ("text-align", "center") ]]
      [ h3 [ style [("font-family", "Helvetica")]] [ text "Subway Stations of New York ", span [ style [("color", dTrainColor )]] [ text "D"], text " Line"]
      ]
    , svg [ width "500", height "1200", viewBox "0 0 500 1200"] <|
      [ rect [ x "10", y "10", width "10", height "1200", fill "#FF6319" ] []
      ] ++ trainStations
    ]

trainStations : List ( Html Msg )
trainStations =
  [ circle [ cx "15", cy (toString   20), r "4", fill "#000000"] [] , text_ [ fontFamily "Helvetica", x "45", y (toString <|   20 + 5)] [ text "205 St" ]
  , circle [ cx "15", cy (toString   50), r "4", fill "#000000"] [] , text_ [ fontFamily "Helvetica", x "45", y (toString <|   50 + 5)] [ text "Bedford Park Blvd" ]
  , circle [ cx "15", cy (toString   80), r "4", fill "#000000"] [] , text_ [ fontFamily "Helvetica", x "45", y (toString <|   80 + 5)] [ text "Kingsbridge Rd" ]
  , circle [ cx "15", cy (toString  110), r "4", fill "#000000"] [] , text_ [ fontFamily "Helvetica", x "45", y (toString <|  110 + 5)] [ text "Fordham Rd" ]
  , circle [ cx "15", cy (toString  140), r "4", fill "#000000"] [] , text_ [ fontFamily "Helvetica", x "45", y (toString <|  140 + 5)] [ text "182-183 Sts" ]
  , circle [ cx "15", cy (toString  170), r "4", fill "#000000"] [] , text_ [ fontFamily "Helvetica", x "45", y (toString <|  170 + 5)] [ text "Tremont Ave" ]
  , circle [ cx "15", cy (toString  200), r "4", fill "#000000"] [] , text_ [ fontFamily "Helvetica", x "45", y (toString <|  200 + 5)] [ text "174-175 St" ]
  , circle [ cx "15", cy (toString  230), r "4", fill "#000000"] [] , text_ [ fontFamily "Helvetica", x "45", y (toString <|  230 + 5)] [ text "170 St" ]
  , circle [ cx "15", cy (toString  260), r "4", fill "#000000"] [] , text_ [ fontFamily "Helvetica", x "45", y (toString <|  260 + 5)] [ text "167 St" ]
  , circle [ cx "15", cy (toString  290), r "4", fill "#000000"] [] , text_ [ fontFamily "Helvetica", x "45", y (toString <|  290 + 5)] [ text "161 St - Yankee Stadium" ]
  , circle [ cx "15", cy (toString  320), r "4", fill "#000000"] [] , text_ [ fontFamily "Helvetica", x "45", y (toString <|  320 + 5)] [ text "155 St" ]
  , circle [ cx "15", cy (toString  350), r "4", fill "#000000"] [] , text_ [ fontFamily "Helvetica", x "45", y (toString <|  350 + 5)] [ text "145 St" ]
  , circle [ cx "15", cy (toString  380), r "4", fill "#000000"] [] , text_ [ fontFamily "Helvetica", x "45", y (toString <|  380 + 5)] [ text "125 St" ]
  , circle [ cx "15", cy (toString  410), r "4", fill "#000000"] [] , text_ [ fontFamily "Helvetica", x "45", y (toString <|  410 + 5)] [ text "59 St - Columbus Circle" ]
  , circle [ cx "15", cy (toString  440), r "4", fill "#000000"] [] , text_ [ fontFamily "Helvetica", x "45", y (toString <|  440 + 5)] [ text "7 Avenue" ]
  , circle [ cx "15", cy (toString  470), r "4", fill "#000000"] [] , text_ [ fontFamily "Helvetica", x "45", y (toString <|  470 + 5)] [ text "47-50 Sts - Rockefeller Center" ]
  , circle [ cx "15", cy (toString  500), r "4", fill "#000000"] [] , text_ [ fontFamily "Helvetica", x "45", y (toString <|  500 + 5)] [ text "42 St - Bryant Park" ]
  , circle [ cx "15", cy (toString  530), r "4", fill "#000000"] [] , text_ [ fontFamily "Helvetica", x "45", y (toString <|  530 + 5)] [ text "34 St - Herald Sq" ]
  , circle [ cx "15", cy (toString  560), r "4", fill "#000000"] [] , text_ [ fontFamily "Helvetica", x "45", y (toString <|  560 + 5)] [ text "W 4 St - Washington Square" ]
  , circle [ cx "15", cy (toString  590), r "4", fill "#000000"] [] , text_ [ fontFamily "Helvetica", x "45", y (toString <|  590 + 5)] [ text "Broadway-Lafayette St / Bleeker St" ]
  , circle [ cx "15", cy (toString  620), r "4", fill "#000000"] [] , text_ [ fontFamily "Helvetica", x "45", y (toString <|  620 + 5)] [ text "Grand St" ]
  , circle [ cx "15", cy (toString  650), r "4", fill "#000000"] [] , text_ [ fontFamily "Helvetica", x "45", y (toString <|  650 + 5)] [ text "Dekalb Ave" ]
  , circle [ cx "15", cy (toString  680), r "4", fill "#000000"] [] , text_ [ fontFamily "Helvetica", x "45", y (toString <|  680 + 5)] [ text "Atlantic Ave / Barclays Center" ]
  , circle [ cx "15", cy (toString  710), r "4", fill "#000000"] [] , text_ [ fontFamily "Helvetica", x "45", y (toString <|  710 + 5)] [ text "Union St" ]
  , circle [ cx "15", cy (toString  740), r "4", fill "#000000"] [] , text_ [ fontFamily "Helvetica", x "45", y (toString <|  740 + 5)] [ text "9 St" ]
  , circle [ cx "15", cy (toString  770), r "4", fill "#000000"] [] , text_ [ fontFamily "Helvetica", x "45", y (toString <|  770 + 5)] [ text "Prospect Ave" ]
  , circle [ cx "15", cy (toString  800), r "4", fill "#000000"] [] , text_ [ fontFamily "Helvetica", x "45", y (toString <|  800 + 5)] [ text "25 St" ]
  , circle [ cx "15", cy (toString  830), r "4", fill "#000000"] [] , text_ [ fontFamily "Helvetica", x "45", y (toString <|  830 + 5)] [ text "36 St" ]
  , circle [ cx "15", cy (toString  860), r "4", fill "#000000"] [] , text_ [ fontFamily "Helvetica", x "45", y (toString <|  860 + 5)] [ text "9 Ave" ]
  , circle [ cx "15", cy (toString  890), r "4", fill "#000000"] [] , text_ [ fontFamily "Helvetica", x "45", y (toString <|  890 + 5)] [ text "Fort Hamilton Parkway" ]
  , circle [ cx "15", cy (toString  920), r "4", fill "#000000"] [] , text_ [ fontFamily "Helvetica", x "45", y (toString <|  920 + 5)] [ text "50 St" ]
  , circle [ cx "15", cy (toString  950), r "4", fill "#000000"] [] , text_ [ fontFamily "Helvetica", x "45", y (toString <|  950 + 5)] [ text "55 St" ]
  , circle [ cx "15", cy (toString  980), r "4", fill "#000000"] [] , text_ [ fontFamily "Helvetica", x "45", y (toString <|  980 + 5)] [ text "62 St" ]
  , circle [ cx "15", cy (toString 1010), r "4", fill "#000000"] [] , text_ [ fontFamily "Helvetica", x "45", y (toString <| 1010 + 5)] [ text "71 St" ]
  , circle [ cx "15", cy (toString 1040), r "4", fill "#000000"] [] , text_ [ fontFamily "Helvetica", x "45", y (toString <| 1040 + 5)] [ text "18 Ave" ]
  , circle [ cx "15", cy (toString 1070), r "4", fill "#000000"] [] , text_ [ fontFamily "Helvetica", x "45", y (toString <| 1070 + 5)] [ text "20 Ave" ]
  , circle [ cx "15", cy (toString 1100), r "4", fill "#000000"] [] , text_ [ fontFamily "Helvetica", x "45", y (toString <| 1100 + 5)] [ text "Bay Parkway" ]
  , circle [ cx "15", cy (toString 1130), r "4", fill "#000000"] [] , text_ [ fontFamily "Helvetica", x "45", y (toString <| 1130 + 5)] [ text "25 Ave" ]
  , circle [ cx "15", cy (toString 1160), r "4", fill "#000000"] [] , text_ [ fontFamily "Helvetica", x "45", y (toString <| 1160 + 5)] [ text "Bay 50 St" ]
  , circle [ cx "15", cy (toString 1190), r "4", fill "#000000"] [] , text_ [ fontFamily "Helvetica", x "45", y (toString <| 1190 + 5)] [ text "Coney Island - Stillwell Ave" ]
  ]
