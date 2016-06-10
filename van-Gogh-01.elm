port module VanGogh exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as Html
-- https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/Image
import Element exposing (image, toHtml)
-- import Random  exposing (..)
import Collage exposing (..)

import String
import List
import Task
import Color exposing (..)
import Array exposing (..)

import Platform.Sub exposing (..)
import Platform.Cmd exposing (..)

width  = 960
height = 500

--main = toHtml ( image width height "starry-night.jpg" )

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

-- subscriptions

port getImageData : () -> Cmd msg

port getPolygons : () -> Cmd msg

port polygons : ( ( List Polygon ) -> msg ) -> Sub msg

-- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Uint8ClampedArray
-- https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/Image
port pixels : ( ImageData -> msg ) -> Sub msg

subscriptions: Model -> Sub Msg
subscriptions model = Platform.Sub.batch [ polygons MyPolygons , pixels MyImage ]

-- MODEL

type alias Point = (Float, Float)

type alias Polygon = List Point

type alias ImageData = {width: Int, height: Int, data: Array Int}

type alias Model = { polygons : List Polygon, pic: ImageData }

-- VIEW

info: String
info = "In mathematics, a Voronoi diagram is a partitioning of a plane into regions based on distance to points in a specific subset of the plane. That set of points (called seeds, sites, or generators) is specified beforehand, and for each seed there is a corresponding region consisting of all points closer to that seed than to any other. These regions are called Voronoi cells. The Voronoi diagram of a set of points is dual to its Delaunay triangulation."

moreInfo : String
moreInfo = "Van Gogh's famous painting Starry Night, re-imagined using the techniques of geometric abstraction.  Colors taken from Van Gogh, polygons by Voronoi Tesslation algorithm. Random points through Uniform Random Sampling (instead of Poisson Disc Sampling). Data Stored by Array of Integer pairs (instead of Quadtree)."

myStyle : List (String, String)
myStyle = [ ("width",  "960px" )  , ("text-align", "justify"), ("background-color", "#FAFAFA")]

view: Model -> Html Msg
view model = div [ class "myTitle"]
  [ h1 [] [ Html.text "Paint By Numbers - Starry Night" ]
  , p [ Html.Attributes.style myStyle ] [ Html.text moreInfo  ]
  , p [ Html.Attributes.style myStyle ] [ Html.text info ]
  , toHtml <| image width height "starry-night.jpg"
  , hr [Html.Attributes.style [ ("width", "960px" ), ("margin-left", "0")] ] []
  , toHtml <| collage width height <| coloredTiling model.polygons model.pic
  , hr [Html.Attributes.style [ ("width", "960px" ), ("margin-left", "0")] ] []
  ]

tiling : List Polygon -> ImageData -> List Form
tiling x y = List.map tile x

tile :  Polygon -> Form
tile y = ( outlined <| solid black ) (polygon y)

get' : Maybe Int -> Array Int -> Maybe Int
get' x y =
  case x of
    Nothing -> Just 0
    Just a  -> get a y

rgb' : Maybe Int -> Maybe Int -> Maybe Int -> Color
{-rgb' a b c =
  case a of
    Nothing -> rgb 255 255 255
    Just a' -> case b of
      Nothing -> rgb a' 0 0
      Just b' -> case c of
        Nothing -> rgb a' b' 0
        Just c' -> rgb a' b' c' -}

rgb' a b c =
  case a of
    Nothing -> rgb 255 255 255
    Just a' -> case b of
      Nothing -> rgb 255 255 255
      Just b' -> case c of
        Nothing -> rgb 255 255 255
        Just c' -> rgb a' b' c'

getColor : Polygon -> ImageData -> Color
getColor x y =
  let
    m : Int
    m = getIndex x y
  in
    rgb' ( get m y.data ) ( get (m+1) y.data ) ( get (m+2) y.data )

getIndex : Polygon -> ImageData -> Int
getIndex x y =
  case List.head x of
    Nothing -> 20001
    -- what if there were 3-tuple or n-tuple
    Just z  -> 4*( y.width*( (round <| snd z)+ 250 ) + ( (round <| fst z)+ 480 ))

reflect: Point -> Point
reflect pt = ( fst pt, -1 * snd pt)

coloredTile :  Polygon -> Color -> Form
coloredTile x y =  filled y <| polygon <| List.map reflect x

f : ImageData -> Polygon -> Form
f y z = coloredTile z ( getColor z y )

coloredTiling : List Polygon -> ImageData -> List Form
coloredTiling x y = List.map ( f y ) x

-- UPDATE

type Msg = GetData | MyPolygons (List Polygon) | GetPolygon | MyImage ImageData


update: Msg -> Model -> (Model, Cmd msg)
update msg model =
  case msg of
    GetData    -> (model   , getImageData () )
    GetPolygon -> (model   , getPolygons  () )
    MyPolygons x -> (Model x model.pic      , Cmd.none        )
    MyImage  x   -> (Model model.polygons x , Cmd.none        )

-- INIT

init: (Model, Cmd Msg)
init = ( Model [] <| ImageData width height Array.empty  , Platform.Cmd.batch [send GetPolygon, send GetData] )
-- init = ( Model [] <| ImageData width height []  , Platform.Cmd.batch [send GetPolygon ] )
-- init = ( Model [] <| ImageData width height []  , Platform.Cmd.batch [send GetData ] )


send : msg -> Cmd msg
send msg =
  Task.perform identity identity (Task.succeed msg)
