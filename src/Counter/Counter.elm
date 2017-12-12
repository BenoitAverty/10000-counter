module Counter exposing (..)

import Html exposing (beginnerProgram)

import Model exposing (initialModel)
import View exposing (view)
import Update exposing (update)

main =
    Html.beginnerProgram { model = initialModel, view = view, update = update }
