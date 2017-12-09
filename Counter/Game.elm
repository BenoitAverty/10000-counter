import Html exposing (..)
import Html.Attributes exposing (..)
import List exposing (..)

main =
    Html.beginnerProgram { model = model, view = view, update = update }

-- MODEL

type GameState = InProgress | Finished

type alias Player = (String, List Int)

type alias Game = List Player
model = [("Benoit", [0]), ("Marie", [0])]

-- UPDATE

-- type Msg = RegisterScore s | Restart
type Msg = Plouf

-- addScore : Int -> String -> Player -> Player
-- addScore score playerName (n, s) = 
--     if n == playerName then (n, s + score) else (n, s)

-- update : Msg -> Model -> Model
-- update msg model =
--     case msg of
--         RegisterScore s ->
--             { players = map (addScore s model.turn) model.players
--             , turn = nextTurn model.players model.turn
--             }
--         Restart -> model

update : Msg -> Game -> Game
update msg game = game

-- VIEW

playerView : Player -> Html Msg
playerView (name, scores) = div [class "player"]
            (
                [ h1 [] [ text name ] ] ++ (List.map (\s -> p [] [text (toString s)]) scores)
            )

view : Game -> Html Msg
view model =
    div [ id "game" ]
        ((input [] []) :: 
        (List.map playerView model))
