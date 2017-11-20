module Point
( point,
  xval,
  yval,
  zval,
  mval,
  translate,
  translateX,
  translateY,
  translateZ,
  translateM
) where

{-|
    A Point is a 0-dimensional geometric object and represents a single location
     in coordinate space. A Point has an x-coordinate value, a y-coordinate
     value. If called for by the associated Spatial Reference System,
     it may also have coordinate values for z and m.

     The boundary of a Point is the empty set.
-}
data Point = Point Int Int Int Int

-- * Functions

{-|
    Point Functions
-}
point :: Int -> Int -> Int -> Int -> Point
point = Point

xval :: Point -> Int
xval (Point x _ _ _) = x
yval :: Point -> Int
yval (Point _ y _ _) = y
zval :: Point -> Int
zval (Point _ _ z _) = z
mval :: Point -> Int
mval (Point _ _ _ m) = m

translate :: Point -> Int -> Int -> Int -> Int -> Point
translate (Point x1 y1 z1 m1) x2 y2 z2 m2 = Point (x1+x2) (y1+y2) (z1+z2) (m1+m2)

translateX :: Point -> Int -> Point
translateX p x = translate p x 0 0 0

translateY :: Point -> Int -> Point
translateY p y = translate p 0 y 0 0

translateZ :: Point -> Int -> Point
translateZ p z = translate p 0 0 z 0

translateM :: Point -> Int -> Point
translateM p m = translate p 0 0 0 m
