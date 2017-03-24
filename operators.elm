import Html exposing (Html, Attribute, button, div, text, h1, p, span, pre)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style)

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

view model =
  div [ style1 ]
    [ h1 [] [ text "Reflex Dom Basics" ]
    , p  [] [ text "Why does HTML have to be the way it is?  Reflex-Dom offers an alternative way to code HTML "
            , text "with additional rigor provided from the Haskell programming language. "
            , text "On the right side, if you won't know what <p> or <h1> mean, then maybe you can roll your own."
            ]
    , div [ style [("height", "10px")] ] []
    , p [] [ text "Haskell and Reflex-Dom pose a "
           , span [ ] [ text "storytelling challenge"]
           , text "as the coder is being ask to put together a peculiar formulation of HTML with exotic types"
           , text "and unusual operators, invoking the full force of monoids, applicatives and lenses. "
           , text "A great question to ask is whether all of this is really necessary? "
           , text "Our goal is to have the user be able to poke and prod the various symbols and types and processes "
           , text "which will guide us towards making beautiful websites."
           ]
    , p [] [ pre [] [ text """svg :: MonadWidget t m => m ()
    svg =  do
      element "svg" (def & namespace .~ Just "http://www.w3.org/2000/svg") blank
      return ()""" ] ]
    , p [] [ text "My initial reaction is that Reflex-Dom is too complicated.  If I need to draw svg, I can just write a single tag"
           , pre [] [ text "<svg></svg>" ]
           , text " That's too bad.  We are going to take a simple thing and make it uncomprehensible.  When we are done,"
           , text "nobody will understand so much as to tie their own shoes in this language."
           ]
    ]
