module Update exposing (update)

import Model exposing (Model)
import Msg exposing (..)
import Update.PageState


update : Msg -> Model -> ( Model, Cmd Msg )
update msg =
    case msg of
        Navigate page ->
            Update.PageState.update msg
