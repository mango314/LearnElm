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

styleop = style [ ("font-size", "50px") ]

styleop1 = style [ ("font-size", "40px") ]

view model =
  div [ style1 ]
    [ h1 [] [ text "Reflex Dom Basics" ]
    , p  [] [ text "Why does HTML have to be the way it is?  Reflex-Dom offers an alternative way to code HTML "
            , text "with additional rigor provided from the Haskell programming language. "
            , text "We could imagine programming websites without ever mentioning the "
            , code [] [ text "<p>" ]
            , text " and "
            , code [] [ text "<h1>"]
            , text " symbols.  We can roll our own."
            ]
    , p [] [ text "Haskell and Reflex-Dom pose a "
           , span [style [("font-weight", "bold")] ] [ text "storytelling challenge"]
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
    , h1 [ styleop ] [ a [ href "https://hackage.haskell.org/package/base-4.9.1.0/docs/Data-Function.html"
                         , style [( "color", "#30A3E8") ]
                         ] [ code [] [ text "&" ] ] ]
    , p [] [ text "the and operator has type blah blah blah"
           , text "it is very similar to "
           , code [] [ text "$"]
           , text "which hast type"
           , code [] [ pre [] [ text "($) :: (a -> b) -> a -> b"] ]
           , text "this operator has a similar looking type"
           , code [] [ pre [] [ text "(&) :: a -> (a -> b) -> b" ] ]
           , text "these have to do with the math notion of associativity and whether we evaluate function on the right or on the left"
           ]
    , h1 [ styleop ] [ code [] [  text ".~"] ]
    , p [] [ text "this connective has to do with lenses" ]
    , h1 [ styleop ] [ code [] [  text "=:"  ] ]
    , p [] [ text "Not to be confused with ", code [] [text ":="], text " or ", code [] [text "::"], text " this operator is about Haskell Maps"
           , text " ''Map'' is such an ambiguous word anyway."]
    , h1 [ styleop ] [ code [] [ text "=>" ] ]
    , p [ ] [ text "This is called a "
            , span [ style [("font-weight", "bold")] ] [ text "type constraint"]
            , text " and the type constraint is that "
            , code [] [ text "m"]
            , text " is a "
            , code [] [ text "MonadWidget" ]
            , text "."
            ]
    , h1 [ styleop ] [ code [] [ text "()" ] ]
    , p [] [ text """I must double check.  This is basically the empty set.  In Haskell we have a symbol for "nothing"."""]
    , h1 [ styleop1 ] [ code [] [ text "blank"] ]
    , p [] [ text "this connective has to do with lenses" ]
    , h1 [ styleop1 ] [ code [] [ text "def"] ]
    , p [] [ text "this connective has to do with lenses" ]
    , h1 [ styleop1 ] [ code [] [ text "namespace"] ]
    , p [] [ text "this connective has to do with lenses" ]
    , h1 [ styleop1 ] [ code [] [ text "def & namespace"] ]
    , p [] [ text "this connective has to do with lenses" ]
    , h1 [ styleop1 ] [ code [] [ text "element"] ]
    , p [] [ text "of all of these, Element is the most involved being lower-level abstraction than elAttr, elDynAttr, etc." ]
    ]
