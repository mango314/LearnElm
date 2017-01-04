port module VanGogh exposing (..)

import Html  exposing (div, span, button, text, Attribute, img, Html, program, h1, p)
import Html.Events exposing (onClick, onMouseOver, onMouseOut)
import Html.Attributes as Html exposing (style, src, width, height)
import Mouse exposing (Position)

import Svg exposing (rect, svg, Svg)
import Svg.Attributes as Svg exposing (width, height, viewBox, x, y, fill)

-- array has to be completely replace with custom QuadTree
-- starting point: http://elm-lang.org/examples/binary-tree
import Array exposing (..)
import Time  exposing (Time, second)


main =
  program { init = init, view = view, update = update, subscriptions = subscriptions}

-- Elm does not save us from CSS it only makes it more manageable
-- https://developer.mozilla.org/en-US/docs/Web/CSS/display
-- https://developer.mozilla.org/en-US/docs/Web/CSS/float

subscriptions: Model -> Sub Msg
subscriptions model = Sub.batch [ Mouse.moves MouseLocation, getImageData GetImage, Time.every second Tick  ]

-- http://package.elm-lang.org/packages/elm-lang/core/4.0.5/Array
-- http://package.elm-lang.org/packages/elm-lang/core/4.0.5/List
type alias Model = { n: Int, x: Int, y: Int, p: Bool, img: Array Int , time: Int}

type QuadTree a = Empty | Node a (QuadTree a) (QuadTree a) (QuadTree a) (QuadTree a)


init : ( Model, Cmd Msg )
init = ( { n = 0, x = 0, y = 0, p= False , img = Array.empty, time = 0} , Cmd.none  )

buttonStyle : Attribute msg
buttonStyle = style [ ("width", "25px"), ("display", "inline-block") ]

numStyle : Attribute msg
numStyle = style [ ("width", "25px"),("display", "inline-block"), ("text-align", "center")]

display : Model -> Html Msg
display model =
  if model.p
    then text <| "Mouse Location:" ++ " ( " ++ (toString model.x) ++ "," ++ (toString model.y) ++ " )"
  else
    text <| "Mouse Location:" ++ " -------- "

-- idiosyncracy
-- Svg.width  : String -> Attribute Msg
-- Html.width : Int    -> Attribute Msg

toHex: Maybe Int -> String
toHex x = case x of
  Just a -> toString a
  Nothing -> "255"


getR: Array Int -> (Int, Int) -> String
getR image (x,y) = toHex  <| get ( x*4 + 500*4*y     ) image

getG: Array Int -> (Int, Int) -> String
getG image (x,y) = toHex  <| get ( x*4 + 500*4*y + 1 ) image

getB: Array Int -> (Int, Int) -> String
getB image (x,y) = toHex  <| get ( x*4 + 500*4*y + 2 ) image

getColor: Array Int -> (Int,Int) -> String
getColor image x = "rgb(" ++ (getR image x) ++ "," ++ (getG image x) ++ "," ++ (getB image x) ++ ")"

square: Model -> Html Msg
square model =
  if model.p then
    svg [ Svg.width "20", Svg.height "20", Svg.viewBox "0 0 20 20"] [ rect [ Svg.x "0", Svg.y "0", Svg.width "20", Svg.height "20", Svg.fill <| getColor model.img (model.x, model.y)] [] ]
  else
    svg [ Svg.width "20", Svg.height "20", Svg.viewBox "0 0 20 20"] [ rect [ Svg.x "0", Svg.y "0", Svg.width "20", Svg.height "20", Svg.fill "rgb(255,255,255)"            ] [] ]

f : Model -> Int -> Svg Msg
f model t =
  let
    dz = (2*5)*(2^model.n)
    a  = ( t  % ((2*25)//(2^model.n)) )
    b  = ( t // ((2*25)//(2^model.n)) )
  in
    rect
      [ Svg.x      ( toString <| dz*a )
      , Svg.y      ( toString <| dz*b )
      , Svg.width  ( toString <| dz   )
      , Svg.height ( toString <| dz   )
      , Svg.fill  <| getColor model.img ( dz*a  , dz*b  ) ] []

pixel : Model -> Svg Msg
pixel model = svg [ Svg.width "500" , Svg.height "300" ]
  <| Array.toList <|   Array.map (\x -> f model x ) <| Array.fromList
  <| List.range 0 <| ( Array.length model.img     ) // (4*2*2*25*(4^model.n))

view: Model -> Html Msg
view model =

  div [ Html.width 500 ]
    [ h1  [ style [("font-family", "Helvetica")] ] [ text "Starry Night"]
    ,  div [ style [("margin", "2px")]  ]
      [ div [ style [ ("width", "160px") , ("text-align", "left")  , ("display", "inline-block"), ("font-family", "Helvetica")] ] [ text "Current pixel color:" ]
      , div [ style [ ("width", "40px")  , ("text-align", "center"), ("display", "inline-block")]  ] [ square model ]
      , div [ style [ ("width", "225px") , ("text-align", "center"), ("display", "inline-block")]  ] [ ]
--      , button [onClick CheckImage, style [ ("width", "75px")] ] [ text "pixelate!"]
      ]
    , div [ Html.width 500 ] [img [ src "starry-night.jpg", Html.width 500, Html.height 300,  onMouseOver ShowLocation, onMouseOut HideLocation] [] ]
    , div [ Html.width 500 ]
      [ p [ style [("font-family", "Helvetica")] ]
        [ text "Digital version of Van Gogh's Starry Night:"
        , button [ onClick Increment ] [ text "+1" ]
        , button [ onClick Decrement ] [ text "-1" ]
        ]
      ]
    , div [ Html.width 500 ] [ rect [ Svg.width "500" , Svg.height "300", Svg.x "0", Svg.y "0" , Svg.fill "#F0F0F0"] [] , pixel model ]
    ]

type Msg =
  MouseLocation Position | ShowLocation | HideLocation | CheckImage | GetImage ( Array Int ) | Increment | Decrement | Tick Time



-- our example could be read mouse locaation (over image) and return color of pixel at mouse location

update: Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    MouseLocation pt->
      ( {model| x = pt.x - 10, y = pt.y - 35} , Cmd.none )
    ShowLocation ->
      ( {model | p  = True } , Cmd.none)
    HideLocation ->
      ( {model | p = False } , Cmd.none)
    CheckImage ->
      ( model, checkImageData "starry-night.jpg" )
    GetImage x ->
      ( {model | img = x  }, Cmd.none )
    Increment  ->
      if model.n < 3 then
        ( {model | n = model.n + 1} , Cmd.none)
      else
        (model, Cmd.none )
    Decrement  ->
      if model.n > -1 then
        ( {model | n = model.n - 1} , Cmd.none)
      else
        ( model, Cmd.none)
    Tick t ->
      if model.time == 0 then
        ( model, checkImageData "starry-night.jpg" )
      else
        ( model, Cmd.none)

port checkImageData : String -> Cmd msg

port getImageData: (Array Int -> msg ) -> Sub msg
