module Model exposing (..)

-- Imports
import Array exposing (Array, map)
import List exposing (filter, head)

import Utils exposing (default)
import ButtonInput


-- Model definition
type LevelState = Default | Strike | CrossedOff


type alias Level = 
    (Int, LevelState)


type alias Player = 
    { name: String
    , levels: List Level
    }


type alias Model = 
    { players : Array Player
    , turn : Int
    , buttonInputModel : ButtonInput.Model
    }


initialModel : Model
initialModel = 
    { players = Array.fromList [Player "Benoit" [(0, Default)], Player "Marie" [(0, Default)]]
    , turn = 0
    , buttonInputModel = ButtonInput.initialModel
    }


currentPlayer : Model -> Player
currentPlayer game = 
    let p = Array.get game.turn game.players in
        case p of
            Nothing -> Player "" []
            Just x -> x


nextTurn : Model -> Int
nextTurn game = (game.turn + 1) % Array.length game.players


currentScoreOf : Player -> Int
currentScoreOf = 
    .levels >> filter (\l -> Tuple.second l /= CrossedOff) >> List.map Tuple.first >> head >> Utils.default 0