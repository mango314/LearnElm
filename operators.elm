module Operators exposing (..)

import Html exposing (Html, Attribute, button, div, text, h1, p, span, pre, code, a)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style, href)

main =
  Html.beginnerProgram { model = 0, view = view, update = update }

type Msg = Increment | Decrement

update msg model =
  case msg of
    Increment ->
      model + 1

    Decrement ->
      model - 1


style1 = style [ ("font-family" , "Helvetica"), ("width", "750px"), ("margin-left", "1%"), ("text-align", "justify")]

styleop = style [ ("font-size", "40px"), ("font-weight", "100") ]

styleop1 = style [ ("font-size", "30px") ]

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
    [ h1 [] [ text "Reflex Dom Basics" ]
    , p  [] [ text "Why does HTML have to be the way it is?  Reflex-Dom offers an alternative way to code HTML "
            , text "with additional rigor provided from the Haskell programming language. "
            , text "We could imagine programming websites without ever mentioning the "
            , code_ "<p>"
            , text " and "
            , code_ "<h1>"
            , text " symbols.  We can roll our own."
            ]
    , p [] [ text "Haskell and Reflex-Dom pose a "
           , boldText "storytelling challenge"
           , text " as the coder is being asked to put together a peculiar formulation of HTML with exotic types "
           , text "and unusual operators, invoking the full force of monads, applicatives and lenses. "
           , text "A great question to ask is whether all of this is really necessary? "
           , text "Our goal is to have the user be able to poke and prod the various symbols and types and processes "
           , text "which will guide us towards making beautiful websites."
           ]
    , p [] [ pre [] [ text """svg :: MonadWidget t m => m ()
svg =  do
  element "svg" (def & namespace .~ Just "http://www.w3.org/2000/svg") blank
  return ()""" ] ]
    , p [] [ text "Reflex-Dom is too complicated.  If I need to draw svg, I can just write a single tag"
           , pre [] [ text "<svg></svg>" ]
           , text " That's too bad.  We are going to take a simple thing and make it uncomprehensible.  When we are done, "
           , text "nobody will understand so much as to tie their own shoes in this language."
           ]
    , h1_ ( Just "https://hackage.haskell.org/package/base-4.9.1.0/docs/Data-Function.html" ) "&"
    , p [] [ text "the and operator has type blah blah blah"
           , text "it is very similar to "
           , code [] [ text "$"]
           , text "which hast type"
           , code [] [ pre [] [ text "($) :: (a -> b) -> a -> b"] ]
           , text "this operator has a similar looking type"
           , code [] [ pre [] [ text "(&) :: a -> (a -> b) -> b" ] ]
           , text "these have to do with the math notion of associativity and whether we evaluate function on the right or on the left"
           ]
    , h1_ Nothing ".~"
    , p [] [ text "this connective has to do with lenses" ]
    , h1_ Nothing "=:"
    , p [] [ text "Not to be confused with ", code [] [text ":="], text " or ", code [] [text "::"], text " this operator is about Haskell Maps"
           , text " ''Map'' is such an ambiguous word anyway."]
    , h1_ Nothing "=>"
    , p [ ] [ text "This is called a "
            , boldText "type constraint"
            , text " and the type constraint is that "
            , code_ "m"
            , text " is a "
            , code_ "MonadWidget"
            , text "."
            ]
    , h1_ Nothing "()"
    , p [] [ text """I must double check.  This is basically the empty set.  In Haskell we have a symbol for "nothing"."""]
    , h1_fn Nothing "blank"
    , p [] [ text  "There really isn't much to blank.  It is has type "
           , code_ "blank :: Monad m => m ()"
           , text  """This is a way of saying "Nothing" in the category of """
           , boldText "Widgets"
           , text ". The source code to "
           , code_ "blank"
           , text " is "
           , pre [] [ text """blank :: forall m. Monad m => m ()
blank = return ()"""]
           , text "could it be redundant?"
           ]
    , h1_fn Nothing "def"
    , p []  [ text "The default value of an "
            , code_ "ElementConfig"
            , text ".  Nothing more to say."]
    , h1_fn Nothing "namespace"
    , p [] [ text "this connective has to do with lenses" ]
    , h1_fn Nothing """namespace .~ Just "xyz" """
    , p [] [ text "this connective has to do with lenses" ]
    , h1_fn Nothing "element"
    , p []  [ text "Of all of these, Element is the most involved being lower-level abstraction than "
            , code_ "elAttr"
            , text ", "
            , code_ "elDynAttr"
            , text  ", etc."
            , pre [] [ text "element :: Text -> ElementConfig er t m -> m a -> m (Element er (DomBuilderSpace m) t, a)" ]
            , pre [ style [("color", "#E0E0E0")] ] [ text """default element :: ( MonadTransControl f
                     , StT f a ~ a
                     , m ~ f m'
                     , DomBuilderSpace m' ~ DomBuilderSpace m
                     , DomBuilder t m'
                     ) =>""" ]
            , pre [] [ text "Text -> ElementConfig er t m -> m a -> m (Element er (DomBuilderSpace m) t, a)" ]
            , text "This function requires an "
            , code_ "ElementConfig"
            , text " which includes things like namespaces and attributes, as well as a child widget of any kind. "
            , text "These elements expose their events and attributes (including the ones you jusst set)."
            ]
    ]
