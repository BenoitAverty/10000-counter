module ButtonInput exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)

-- Model
type alias Model = String
initialModel : Model
initialModel = ""

-- Update
type Msg = UpdateField String | Submit String

update : Msg -> Model -> Model
update msg model = 
    case msg of 
        UpdateField s -> s
        Submit _ -> initialModel

-- View
buttonInput : String -> Model -> Html Msg
buttonInput p state = 
    div [ class "buttonInput" ]
    [ input 
        [ class "buttonInput"
        , placeholder p
        , onInput UpdateField
        , value state
        ] 
        []
    , button [ onClick <| Submit state ] [ text "Ok" ]
    ]