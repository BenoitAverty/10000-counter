module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import List exposing (reverse)
import Array exposing (Array, toList)

import Model exposing (..)
import Update exposing (Msg(..))
import ButtonInput exposing (buttonInput)


playerNameView : String -> Html Msg
playerNameView name = h1 [] [ text name ]


levelView : Level -> Html Msg
levelView level = 
    case level of
        (s, Default) -> ul [ class "defaultScore" ] [ text (toString s) ]
        (s, Strike) -> ul [ class "strikeScore" ] [ text (toString s), span [] [ text " ·" ] ]
        (s, CrossedOff) -> ul [ class "crossedOffScore" ] [ text (toString s) ]


scoresView : List Level -> Html Msg
scoresView scores = 
    ul [ class "score" ] <| List.map levelView <| reverse scores


playerView : Player -> Html Msg
playerView p = 
    div [class "player"]
        [ playerNameView p.name
        , scoresView p.levels
        ]


playersView : Array Player -> Html Msg
playersView players = div [ class "players" ] <| List.map playerView <| toList players


view : Model -> Html Msg
view game =
    div [ id "game" ]
        [ Html.map ButtonInputMsg <| ButtonInput.buttonInput ((currentPlayer game).name ++ "'s score...") game.buttonInputModel 
        , playersView game.players
        ]
