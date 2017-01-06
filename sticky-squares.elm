import Html exposing (Html, div)

import Svg exposing (Svg)

-- the goal of stacky squares" is an excuse
-- to develops arrays from scratch
-- Elm arrays are known to be "unsafe"
-- most programmer don't think hard about the array
-- (or list type) they are using.
-- in fact we can implement our own array based
-- on a tree.  Our screen is a 2D array and we need
-- to be aware of neighbor relationships. And
-- to move objects from one place to another.

-- this is also to prove we can write Elm Array'
-- type without every writing native JS code

-- lastly please don't let the term "ballistic deposition"
-- scare you it is just a bunch of stacky squares

main = Html.program
  { init = init
  , view = view
  , update = update
  , subscriptions = subscriptions }


-- Model

type alias Model = { n : Int }

-- somewhat nervous here.  do I want a doubly-linked list?
-- DOUBLY LINKED LISTS NOT POSSIBLE IN FP
-- http://stackoverflow.com/questions/10386616/how-to-implement-doubly-linked-lists
-- https://wiki.haskell.org/Tying_the_Knot
-- https://wiki.haskell.org/ZipperA
type Graph a = Empty | Node a (Graph a) (Graph a)



-- examples of graphs
-- Aztec Diamond
-- m x n rectangle

rectangle : Int -> Int -> Graph (Svg Msg)
rectangle m n =
  -- WRONG!
  case (m,n) of
    (m,0) -> Empty
    (0,n) -> Empty
    (m,1) -> Graph ( svg [] [] )   Empty               ( rectangle (m-1) 1 )
    (1,n) -> Graph ( svg [] [] ) ( rectangle 1 (n-1) )   Empty
    _     ->
      let
        G = rectangle (m-1) n
      in
        Graph ( svg [] [] ) (  ) (  )

type Msg = Go

init : ( Model, Cmd Msg )
init = ( Model 0, Cmd.none )

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = (model, Cmd.none)

view : Model -> Html Msg
view model = div [] []

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none
