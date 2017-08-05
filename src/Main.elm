module Main exposing (..)

import Model
import Msg
import Navigation
import Update
import View
import Router


init : Navigation.Location -> ( Model.Model, Cmd Msg.Msg )
init loc =
    Model.init
        |> Router.routeInit loc


main : Program Never Model.Model Msg.Msg
main =
    Navigation.program
        Router.routeMsg
        { init = init
        , update = Update.update
        , view = View.view
        , subscriptions = \_ -> Sub.none
        }
