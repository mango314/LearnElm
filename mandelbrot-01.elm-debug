import Html exposing (Html, Attribute, button, div, text)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style)


main =
  Html.beginnerProgram { model = model, view = view, update = update }


-- MODEL

type alias Model = List (Point, Point)

type alis Point { x: Int, y: Int}

model : Model
model = [ (Point 0 0, Point 0 1)
, (Point 0 1, Point 1 1)
, (Point 1 1, Point 0 1)
, (Point 1 0, Point 0 0) ]


-- UPDATE

type Msg = Increment | Decrement

update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      model + 1

    Decrement ->
      model - 1


-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ div [ style [("display"), ("inline-block")] ] [ button [ onClick Decrement ] [ text "-" ] ]
    , div [ style [("display"), ("inline-block")] ] [ div [] [ text (toString model) ] ]
    , div [ style [("display"), ("inline-block")] ] [ button [ onClick Increment ] [ text "+" ] ]
    , div [] [ svg [ style [("width", "500"), ("height", "500")]] [] ]
    ]
