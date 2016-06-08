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

type alias ImageData = {width: Int, height: Int, data: List Int}

type alias Model = { polygons : List Polygon, pic: ImageData }

-- VIEW

info: String
info = "In mathematics, a Voronoi diagram is a partitioning of a plane into regions based on distance to points in a specific subset of the plane. That set of points (called seeds, sites, or generators) is specified beforehand, and for each seed there is a corresponding region consisting of all points closer to that seed than to any other. These regions are called Voronoi cells. The Voronoi diagram of a set of points is dual to its Delaunay triangulation."

moreInfo : String
moreInfo = "Painting starry night, Polygons by Voronoi Tesslation, Random Points through Uniform Random Sampling (instead of Poisson Disc Sampling), Data Stored by Array of Integer pairs (instead of Quadtree)."

myStyle : List (String, String)
myStyle = [ ("width",  "960px" )  , ("text-align", "justify"), ("background-color", "#FAFAFA")]

view: Model -> Html Msg
view model = div [ class "myTitle"]
  [ h1 [] [ Html.text "Starry Night" ]
  , p [ Html.Attributes.style myStyle ] [ Html.text moreInfo  ]
  , p [ Html.Attributes.style myStyle ] [ Html.text info ]
  , toHtml <| image width height "starry-night.jpg"
  , hr [Html.Attributes.style [ ("width", "960px" ), ("margin-left", "0")] ] []
  , toHtml <| collage width height <| tiling model.polygons model.pic
  , hr [Html.Attributes.style [ ("width", "960px" ), ("margin-left", "0")] ] []
  ]

tiling : List Polygon -> ImageData -> List Form
tiling x y = List.map tile x

tile :  Polygon -> Form
tile y = ( outlined <| solid black ) (polygon y)

getColor : Polygon -> ImageData -> Color:
getColor x y = 

getIndex : Polygon -> ImageData -> Maybe Int
getIndex p =
  case List.head p of
    Nothing -> Nothing
    -- what if there were 3-tuple or n-tuple
    Just x y -> Just (4*y.width)*( round <| fst x ) + round <| snd x

coloredTile : Color -> Polygon -> Form
coloredTile x y =  filled x <| polygon y

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
init = ( Model [] <| ImageData width height []  , Platform.Cmd.batch [send GetPolygon, send GetData] )
-- init = ( Model [] <| ImageData width height []  , Platform.Cmd.batch [send GetPolygon ] )
-- init = ( Model [] <| ImageData width height []  , Platform.Cmd.batch [send GetData ] )


send : msg -> Cmd msg
send msg =
  Task.perform identity identity (Task.succeed msg)
