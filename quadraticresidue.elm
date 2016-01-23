# http://www.share-elm.com/sprout/56a3bfb0e4b070fd20da92c9
import Graphics.Element exposing (show)
main = show ( (List.map (f 41)) [1..41] )

-- http://primes.utm.edu/glossary/xpage/QuadraticResidue.html
-- possible use as "pure" random number generator... still researching
f: Int -> Int -> Int
f p a = (a*a)%p
