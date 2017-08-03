module Main exposing (..)

import Model
import Msg
import Navigation
import Update
import View
import Router
import Cmds.Session


init : Navigation.Location -> ( Model.Model, Cmd Msg.Msg )
init loc =
    ( Router.routeInit loc
    , Cmds.Session.getTime
    )


main : Program Never Model.Model Msg.Msg
main =
    Navigation.program
        Router.routeMsg
        { init = init
        , update = Update.update
        , view = View.view
        , subscriptions = \_ -> Sub.none
        }
