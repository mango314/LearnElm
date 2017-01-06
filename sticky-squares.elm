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

-- somewhat nervous here.  do I want a doubly-linked list?
-- DOUBLY LINKED LISTS NOT POSSIBLE IN FP
-- http://stackoverflow.com/questions/10386616/how-to-implement-doubly-linked-lists
-- https://wiki.haskell.org/Tying_the_Knot
-- https://wiki.haskell.org/ZipperA
-- GRAPH THEORY (esp cycles) ARE NOT POSSIBLE IN FP
-- http://stackoverflow.com/questions/9732084/how-do-you-represent-a-graph-in-haskell

type alias Model = {
  -- add a single method to retrieve the value at n, n+1, n-1
  stacks : List ( List Maybe Int ),
  -- the squares have to connect to the ground somehow!
  hackenbrush : List ( Tree (Int Int) ) }


type Tree a = Empty | Node a (Tree a) (Tree a)

-- examples of graphs
-- Aztec Diamond
-- m x n rectangle

rectangle : Int -> Int -> List ( List ( Maybe (Svg Msg) ) )
rectangle m n = List.map ( \y -> List.map (\x -> Nothing ) ( List.range 0 (m-1) ) ) ( List.range 0 (n-1) )

type Msg = Drop

-- UPDATE & VIEW
-- kind of a dull app right now

init : ( Model, Cmd Msg )
init = ( Model ( rectangle 10 5 ) [], Cmd.none )


update : Msg -> Model -> (Model, Cmd Msg)
update msg model = (model, Cmd.none)

view : Model -> Html Msg
view model = div [] []

-- SUBSCRIPTIONS
-- no interactions with the "outside world" at this particular moment!

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none
