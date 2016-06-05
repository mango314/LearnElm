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

port pixels : ( ImageData -> msg ) -> Sub msg

-- what happens when you need two subscriptions ?
subscriptions: Model -> Sub Msg
subscriptions model = polygons MyPolygons

--subscriptions: Model -> Sub Msg
--subscriptions model = pixels MyImage

-- MODEL
-- type alias Model = List (Int, Int)

type alias Point = (Float, Float)

type alias Polygon = List Point

type alias ImageData = {width: Int, height: Int, pts: List Int}

type alias Model = { polygons : List Polygon, pic: ImageData }


-- VIEW

info: String
info = "In mathematics, a Voronoi diagram is a partitioning of a plane into regions based on distance to points in a specific subset of the plane. That set of points (called seeds, sites, or generators) is specified beforehand, and for each seed there is a corresponding region consisting of all points closer to that seed than to any other. These regions are called Voronoi cells. The Voronoi diagram of a set of points is dual to its Delaunay triangulation."

view: Model -> Html Msg
view model = div [ class "title"]
  [ h1 [] [ Html.text "Voronoi Tesslation Collage" ]
  , p [ Html.Attributes.width width ] [ Html.text info ]
  , toHtml <| image width height "starry-night.jpg"
  , toHtml <| collage width height <| tiling model.polygons
  ]

tiling: List Polygon -> List Form
tiling x = List.map tile x

tile:  Polygon -> Form
tile y = ( outlined <| solid black ) (polygon y)

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
init = ( Model [] <| ImageData width height [] , send GetPolygon )

send : msg -> Cmd msg
send msg =
  Task.perform identity identity (Task.succeed msg)
