import Point
{-|
    Revisit once linestring has been defined
-}
class (Geometry a) => Curve a where
    length :: a -> Double
    start :: a -> Point
    end :: a -> Point
    isClosed :: a -> Bool
    isRing :: a -> Bool

class (Curve a) => LineString a where
    count :: a -> Int
    nth :: a -> Int -> Point

data LineString = LineString [Point]
instance LineString LineString where
    count (LineString xs) = length xs
    nth (LineString xs) n = xs !! n
data Line = Line [Point]
instance LineString Line where
    count _ = 2
    nth (Line xs) n = xs !! n
data LineRing = LineRing [Point]
instance LineString LineRing where
    count (LineRing xs) = length xs
    nth (LineRing xs) n = xs !! n
