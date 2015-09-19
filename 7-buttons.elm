import Graphics.Element exposing (..)
import Graphics.Input exposing (..)
import Signal exposing (..)


check : Signal.Mailbox Bool
check = Signal.mailbox False

x : Int
x = 7

boxes : Bool -> Element
boxes checked =
    let box = container 30 30 middle (checkbox (Signal.message check.address) checked)
    in
        flow right ( List.map (\z -> box ) [ 1 .. x] )

main : Signal Element
main = boxes <~ check.signal
