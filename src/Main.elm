module Main exposing (..)

import Html
import Model
import Model.PageState
import Msg
import Navigation
import Update
import View


parseLocation : Navigation.Location -> Msg.Msg
parseLocation loc =
    Msg.Navigate <| Model.PageState.parseHash loc.hash


init : Navigation.Location -> ( Model.Model, Cmd Msg.Msg )
init loc =
    ( Model.init <| Model.PageState.parseHash loc.hash, Cmd.none )


main : Program Never Model.Model Msg.Msg
main =
    Navigation.program
        parseLocation
        { init = init
        , update = Update.update
        , view = View.view
        , subscriptions = \_ -> Sub.none
        }
