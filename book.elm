import Html exposing (Html, button, div, text, math, node)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style)
import Array exposing (fromList, get, Array)

-- component for flipping thru the pages of a "book"

main =
  -- notice the similarity to all the other examples in this library :-)
  Html.beginnerProgram { model = model , view = view, update = update }


-- MODEL

type alias Model = { page: Int, book: Array String }

model : Model
model = Model 0 <| fromList [ "Hello World!" , "This is", "A Test" ]


-- UPDATE

type Msg = Increment | Decrement

update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      if model.page == 2 then
        Model model.page model.book
      else
        Model ( model.page + 1 ) model.book
    Decrement ->
      if model.page == 0 then
        Model model.page model.book
      else
        Model ( model.page - 1 ) model.book


-- VIEW

getSlide: Model -> String
getSlide x =
  case get x.page x.book of
    Just y -> y
    Nothing -> "----"

view : Model -> Html Msg
view model =
  div [ style [("width", "500px")] ]
    [ div [style [("margin-bottom", "3px")] ]
      [ div [ style [("display", "inline-block"), ("width", "25px"), ("text-align", "center")] ] [ button [ onClick Decrement , style [("width", "25px")]] [ text "-" ] ]
      , div [ style [("display", "inline-block"), ("width", "50px"), ("text-align", "center")] ] [ text (toString model.page)]
      , div [ style [("display", "inline-block"), ("width", "25px"), ("text-align", "center")] ] [ button [ onClick Increment , style [("width", "25px")]] [ text "+" ] ]
      ]
    , div [ style [("background-color", "#F0F0F0"), ("width", "500px"), ("height", "300px"), ("text-align", "top"), ("padding", "1px")]  ] [ text <| getSlide model ]
    ]
