module Main exposing (..)

import Html.App as App
import Html exposing (..)
import Html.Attributes exposing (..)
import About
import Route
import Navigation
import String exposing (split)
import Topic
import Helpers exposing (link)


type alias Model =
    { route : Route.Model
    }


type Msg
    = NoOp


init : Maybe Route.Location -> ( Model, Cmd Msg )
init location =
    let
        route =
            Route.init location
    in
        { route = route
        }
            ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


view : Model -> Html Msg
view model =
    let
        body =
            case model.route of
                Just (Route.Home) ->
                    About.view

                Just (Route.Topics) ->
                    Topic.view Topic.fakeTopics

                Just (Route.Topic slug) ->
                    Topic.viewTopic slug Topic.fakeTopics

                Nothing ->
                    text "Not found!"
    in
        div []
            [ navigationView model
            , body
            ]


navigationView : Model -> Html Msg
navigationView model =
    nav []
        [ ul []
            [ li [] [ link ( Route.Home, "Home" ) ]
            , li [] [ link ( Route.Topics, "Topics" ) ]
            ]
        ]


currentPageView : Model -> Html Msg
currentPageView model =
    text "home page"


updateRoute : Maybe Route.Location -> Model -> ( Model, Cmd Msg )
updateRoute route model =
    { model | route = route } ! []


main : Program Never
main =
    Navigation.program (Navigation.makeParser Route.locFor)
        { init = init
        , update = update
        , urlUpdate = updateRoute
        , view = view
        , subscriptions = subscriptions
        }
