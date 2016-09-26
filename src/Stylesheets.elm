port module Stylesheets exposing (..)

import Css.File exposing (..)
import Html exposing (div)
import Html.App as App
import Styles


-- We specify our files with an outbound port to the node program that embeds it


port files : CssFileStructure -> Cmd msg



-- Our cssFiles specify which files represent which styles


cssFiles : CssFileStructure
cssFiles =
    toFileStructure [ ( "styles.css", compile [ Styles.css ] ) ]



-- Then we produce a program that just sends this data out the port on load.
-- Richard is basically a hero when it comes to making Elm applications do
-- things you didn't think they trivially could, like output files to the
-- filesystem in this case.


main : Program Never
main =
    App.program
        { init = ( (), files cssFiles )
        , view = \_ -> (div [] [])
        , update = \_ _ -> ( (), Cmd.none )
        , subscriptions = \_ -> Sub.none
        }
