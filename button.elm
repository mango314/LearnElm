module Operators exposing (..)

import Html exposing (Html, Attribute, button, div, text, h1, p, span, pre, code, a)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style, href)

main =
  Html.beginnerProgram { model = 0, view = view, update = update }

type Msg = Increment

update msg model =
  case msg of
    Increment ->
      1 - model


style1 = style [ ("font-family" , "Helvetica"), ("width", "750px"), ("margin-left", "1%"), ("text-align", "justify")]

styleop = style [ ("font-size", "30px"), ("font-weight", "100") ]

styleop1 = style [ ("font-size", "20px") ]

h1_ url x = case url of
  Just url_  -> h1 [ styleop ] [ a [ href url_
                     , style [( "color", "#30A3E8"), ("text-decoration", "none")]
                     ] [ code [] [ text x ] ] ]
  Nothing -> h1 [ styleop ] [ a [ href ""
                     , style [( "color", "#30A3E8"), ("text-decoration", "none")]
                     ] [ code [] [ text x ] ] ]

h1_fn  url x = case url of
  Just url_  -> h1 [ styleop ] [ a [ href url_
                     , style [( "color", "#6DF22B"), ("text-decoration", "none")]
                     ] [ code [] [ text x ] ] ]
  Nothing -> h1 [ styleop ] [ a [ href ""
                     , style [( "color", "#6DF22B"), ("text-decoration", "none")]
                     ] [ code [] [ text x ] ] ]

-- https://developer.mozilla.org/en-US/docs/Web/CSS/font-weight
boldText x = span [ style [("font-weight", "bold")] ] [ text x]

code_ x = code [] [ text x ]

view model =
  div [ style1 ]
    [ h1 [] [ text "Button" ]
    , p  [] [ text "Static webpages are nice, Reflex is a type of FRP (Functional Reactive Programming) "
            , text "I have no idea how mouse events work in this language: what happens when you click a button? Or a dropdown menu?"
            ]
    , p  [] [ text "The code for dropDown.  It is pretty overwhelming.  Here is the code for "
            , code_ "button"
            , text "."]
    , pre [] [ text """button :: DomBuilder t m => Text -> m (Event t ())
button t = do
  (e, _) <- element "button" def $ text t
  return $ domEvent Click e""" ]
    , p [] [ text "That was easy.  What happens after you click the button? At this point we seem to leave Reflex-Dom"]
    , pre [] [ text """count :: (Reflex t, MonadHold t m, MonadFix m, Num b) => Event t a -> m (Dynamic t b)
count e = holdDyn 0 =<< zipListWithEvent const (iterate (+1) 1) e"""]
    , p []  [ text "and off we go... The exercise could be to combine "
            , code_ "button"
            , text " and "
            , code_ "count"
            , text " and write to some kind of "
            , code_ "text"
            , text " element."
            ]
    , p []  [ text "This is our first instance of monads. There are at least two: "
            , code_ "monadHold"
            , text " and "
            , code_ "monadWidget"
            , text ".  My first impression is that "
            , code_ "count"
            , text " has the wrong type.  It should be"
            , pre [] [ text "m ( Event t a )" ]
            , text "but we only have "
            , code_ "Event t ()"
            , text " maybe we need to use the "
            , code_ ">>>"
            , text " symbol."]
    ]
