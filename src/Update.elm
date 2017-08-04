module Update exposing (update)

import Model exposing (Model)
import Msg
import Update.Conversion
import Update.PageState
import Update.Session


update : Msg.Msg -> Model -> ( Model, Cmd Msg.Msg )
update msg =
    case msg of
        Msg.PageState msg ->
            Update.PageState.update msg

        Msg.Conversion msg ->
            Update.Conversion.update msg

        Msg.Session msg ->
            Update.Session.update msg
