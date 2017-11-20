{-|
Module      : Geometry
Description : Definition of Types to implement the Simple Feature Access Spec
Definition of Types to implement the Simple Feature Access Spec
-}

-- * Classes
{-|
    The Geometry type class which defines the behavior of all Geometries.
    Perhaps all of these definitions do not belong in the type class, but
    in the data type definitions themselves. Or perhaps seperate type classes
    that would capture the different method groupings
-}
class Geometry a where
    {-|
        The inherent dimension of this geometric object, which must be less
        than or equal to the coordinate dimension. In non-homogeneous
        collections, this will return the largest topological dimension of the
        contained objects.
    -}
    dimension :: a -> Int
    {-|
        Returns the name of the subtype of Geometry of which this
        geometric object represents.
    -}
    geometryType :: a -> String
    {-|
         Returns the Spatial Reference System for this geometric object.
    -}
    srid :: a -> Int
    {-|
        The minimum bounding box for this Geometry, returned as a Geometry. The
        polygon is defined by the corner points of the bounding box:
        [(MINX, MINY), (MAXX, MINY), (MAXX, MAXY), (MINX, MAXY), (MINX, MINY)]
        Minimums for Z and M may be added. The simplest representation of an
        Envelope is as two direct positions, one containing all the minimums,
        and another all the maximums. In some cases, this coordinate will be
        outside the range of validity for the Spatial Reference System.
    -}
    envelope :: a -> a
    {-|
         Exports this geometric object to a specific Well-known Text
         Representation of Geometry.
    -}
    asText :: a -> String
    {-
        Exports this geometric object to a specific Well-known Binary
        Representation of Geometry.
    asBinary :: a -> ?? -}
    {-|
        Returns TRUE if this geometric object is the empty Geometry. If true,
        then this geometric object represents the empty point set ∅ for the
        coordinate space.
    -}
    isEmpty :: a -> Bool
    {-|
        Returns TRUE if this geometric object has no anomalous geometric
        points, such as self intersection or self tangency. The description of
        each geometric class will include the specific conditions that cause an
        instance of that class to be classified as not simple.
    -}
    isSimple :: a -> Int
    {-|
         Returns TRUE if this geometric object has z coordinate values.
    -}
    is3d :: a -> Bool
    {-|
         Returns TRUE if this geometric object has m coordinate values.
    -}
    isMeasured :: a -> Bool
    {-|
        Returns the closure of the combinatorial boundary of this geometric
        object. Because the result of this function is a closure, and hence
        topologically closed, the resulting boundary can be represented using
        representational Geometry primitives
    -}
    boundary :: a -> a
    {-|
        Returns TRUE if the first geometric object is “spatially equal” to the
        other geometry.
    -}
    equals :: a -> a -> Bool
    {-|
        Returns TRUE if the first geometric object is “spatially disjoint” to
        the other geometry.
    -}
    disjoint :: a -> a -> Bool
    {-|
        Returns TRUE if the first geometric object “spatially intersects” the
        other geometry.
    -}
    intersects :: a -> a -> Bool
    {-|
        Returns TRUE if the first geometric object “spatially touches” the
        other geometry.
    -}
    touches :: a -> a -> Bool
    {-|
        Returns TRUE if the first geometric object is “spatially crosses” the
        other geometry.
    -}
    crosses :: a -> a -> Bool
    {-|
        Returns TRUE if the first geometric object is “spatially within” the
        other geometry.
    -}
    within :: a -> a -> Bool
    {-|
        Returns TRUE if the first geometric object is “spatially contains” the
        other geometry.
    -}
    contains :: a -> a -> Bool
    {-|
        Returns TRUE if the first geometric object is “spatially overlaps" the
        other geometry.
    -}
    overlaps :: a -> a -> Bool
    {-|
        Returns TRUE if the first geometric object is spatially related to the
        other Geometry by testing for intersections between the interior,
        boundary and exterior of the two geometric objects as specified by the
        values in the intersectionPatternMatrix String. This returns FALSE if
        all the tested intersections are empty except exterior (first)
        intersect exterior (other).
    -}
    relate :: a -> a -> String -> Int
    {-|
        Returns a derived geometry collection value that matches the specified
        m coordinate value.
    -}
    locateAlong :: a -> Double -> a
    {-|
        Returns a derived geometry collection value that matches the specified
        range of m coordinate values inclusively.
    -}
    locateBetween :: a -> Double -> Double -> a
    {-|
        Returns the shortest distance between any two Points in the two
        geometric objects as calculated in the spatial reference system of the
        first geometric object. Because the geometries are closed, it is
        possible to find a point on each geometric object involved, such that
        the distance between these 2 points is the returned distance between
        their geometric objects.
    -}
    distance :: a -> a -> Double
    {-|
        Returns a geometric object that represents all Points whose distance
        from the given geometric object is less than or equal to distance.
        Calculations are in the spatial reference system of the given geometric
        object. Because of the limitations of linear interpolation, there will
        often be some relatively small error in this distance, but it should be
        near the resolution of the coordinates used.
    -}
    buffer :: a -> Double -> a
    {-|
        Returns a geometric object that represents the convex hull of the given
        geometric object. Convex hulls, being dependent on straight lines, can
        be accurately represented in linear interpolations for any geometry
        restricted to linear interpolations.
    -}
    convexHull :: a -> a
    {-|
        Returns a geometric object that represents the Point set intersection
        of the first geometric object with the second.
    -}
    intersection :: a -> a -> a
    {-|
        Returns a geometric object that represents the Point set union of the
        first geometric object with the second
    -}
    union :: a -> a -> a
    {-|
        Returns a geometric object that represents the Point set difference of
        the first geometric object with the second.
    -}
    difference :: a -> a -> a
    {-|
        Returns a geometric object that represents the Point set symmetric
        difference of the first geometric object with the second.
    -}
    symDifference :: a -> a -> a

{-|
    A GeometryCollection is a geometric object that is a collection of some
    number of geometric objects.

    All the elements in a GeometryCollection shall be in the same Spatial
    Reference System. This is also the Spatial Reference System for the
    GeometryCollection.

    GeometryCollection places no other constraints on its elements. Subclasses
    of GeometryCollection may restrict membership based on dimension and may
    also place other constraints on the degree of spatial overlap between
    elements.

    Two collections whose difference is only this order are spatially equal
    and will return equivalent results in any geometric-defined operations.

    Perhaps this should implement Foldable, or some other iterator like
    type class
-}
class (Geometry a) => GeometryCollection a where
    {-|
         Returns the number of geometries in the GeometryCollection.
    -}
    count :: a -> Int
    {-|
        Returns the Nth geometry in the GeometryCollection.
    -}
    nth :: (Geometry b) => a -> Int -> b

-- * Types
