import Html exposing (Html, div)

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
type Graph a = Empty | Node a (Graph a) (Graph a) (Graph a) (Graph a)

-- examples of graphs
-- Aztec Diamond
-- m x n rectangle

rectangle : Graph Svg
rectangle = Empty

type Msg = Go

init : ( Model, Cmd Msg )
init = ( Model 0, Cmd.none )

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = (model, Cmd.none)

view : Model -> Html Msg
view model = div [] []

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none
