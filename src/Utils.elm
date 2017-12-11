module Utils exposing (..)

import Array exposing (Array, map)
import List exposing (map)

mapIfA : (a -> Bool) -> (a -> a) -> Array a -> Array a
mapIfA predicate function list = 
    let f x = if predicate x then function x else x in
    Array.map f list

mapIfL : (a -> Bool) -> (a -> a) -> List a -> List a
mapIfL predicate function list = 
    let f x = if predicate x then function x else x in
    List.map f list

mapLast : (a -> a) -> List a -> List a
mapLast f l = 
    case l of
        [] -> []
        x::[] -> f x :: []
        x::xs -> x :: mapLast f xs

default : a -> Maybe a -> a
default value maybe = 
    case maybe of
        Nothing -> value
        Just x -> x