I am playing with the Elm examples, and I noticed the [field](http://elm-lang.org/examples/field) example gives `Result` types.  After getting stuck, I came up with this simplified case: 

    import Html exposing (text)
    import String
    
    f: Int -> Int
    f x = x + 1
    
    g: Result String Int -> Result String Int
    g x = (Result.map f) x

    main =
      text (  toString ( g  (String.toInt 5 ) ))

The result displays **`OK 6`** and I would rather it display just **`6`** -- I know that `toString` takes any type and returns a string representaton of it.  So maybe I can modify `toString`

* if result is `OK` then I can print the numerical result
* if the result is `Err` then I would like do some custom error message

Possibly this is the reason for the [`andThen`](http://package.elm-lang.org/packages/elm-lang/core/1.0.0/Result#andThen) since the `+ 1` operation can fail.

    andThen : Result e a -> (a -> Result e b) -> Result e b
    andThen result callback =
        case result of
          Ok value -> callback value
          Err msg -> Err msg

The definitio of **`andThen`** is exactly what it does... and is an instance of [`case`](http://elm-lang.org/docs/syntax#conditionals)
