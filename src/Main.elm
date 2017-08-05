module Main exposing (..)

import Navigation


--

import Model
import Msg
import Router
import Update
import View


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
