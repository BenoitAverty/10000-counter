module Update exposing (..)

import Array exposing (..)

import Model exposing (..)
import ButtonInput
import Utils exposing (mapLast, mapIfL, mapIfA)

type Msg = ButtonInputMsg ButtonInput.Msg

strikeLevel : Level -> Level
strikeLevel level = 
    case level of
        (s, Default) -> (s, Strike)
        (s, _) -> (s, CrossedOff)


strikeLastLevel : List Level -> List Level
strikeLastLevel levels =
    case levels of 
        [] -> []
        (s, CrossedOff)::rest -> (s, CrossedOff)::strikeLastLevel rest
        head::rest -> strikeLevel head::rest
        


strikePlayer : Player -> Player
strikePlayer player = Player player.name (strikeLastLevel player.levels)

strike : Player -> Array Player -> Array Player
strike currentPlayer = 
    mapIfA (\p -> p.name == currentPlayer.name) strikePlayer


appendLevel : Int -> Player -> Player
appendLevel newScore player = 
    Player player.name ((newScore, Default) :: player.levels)


crossOffDuplicateLevels : Int -> Player -> Player
crossOffDuplicateLevels s p = 
    let crossOff (s, _) = (s, CrossedOff) in 
        Player p.name (mapIfL (\l -> Tuple.first l == s) crossOff p.levels)


registerScore : Int -> Player -> Array Player -> Array Player
registerScore score currentPlayer = 
    let newScore = score + currentScoreOf currentPlayer in
        Array.map (crossOffDuplicateLevels newScore)
        >> mapIfA (\p -> p.name == currentPlayer.name) (appendLevel newScore)

handleSubmit : String -> Model -> Model
handleSubmit str game = 
    let intResult = if str=="" then Ok 0 else String.toInt str in
        case intResult of
            Ok 0 -> 
                { game
                | players = strike (currentPlayer game) game.players
                , turn = nextTurn game
                }
            Ok turnScore -> 
                { game
                | players = registerScore turnScore (currentPlayer game) game.players
                , turn = nextTurn game
                }
            Err error -> game


update : Msg -> Model -> Model
update msg game = 
    case msg of
        -- Handle the submit message of buttonInput
        ButtonInputMsg (ButtonInput.Submit str) -> 
            let newModel = handleSubmit str game in
            { newModel
            | buttonInputModel = ButtonInput.update (ButtonInput.Submit str) game.buttonInputModel
            }
        
        -- Unhandled ButtonInput messages are just passed through
        ButtonInputMsg m -> { game | buttonInputModel = ButtonInput.update m game.buttonInputModel }