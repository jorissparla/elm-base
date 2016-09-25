module Route exposing (..)

import String exposing (split)
import Navigation


type Location
    = Home
    | Topics


type alias Model =
    Maybe Location


locFor : Navigation.Location -> Maybe Location
locFor path =
    let
        -- We'll look at the path's hash and split on slash, ignoring empty
        -- segments and the hash symbol.
        segments =
            path.hash
                |> split "/"
                |> List.filter (\seg -> seg /= "" && seg /= "#")
    in
        case segments of
            -- No segments means we're on the home page
            [] ->
                Just Home

            -- "/topics" means we're on the topics page
            [ "topics" ] ->
                Just Topics

            -- Otherwise, return `Nothing` and let our "not found" view take over
            _ ->
                Nothing


init : Maybe Location -> Model
init location =
    location
