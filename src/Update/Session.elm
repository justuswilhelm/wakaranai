module Update.Session exposing (update)

import Msg
import Msg.Session exposing (..)
import Model exposing (Model)


update : Msg -> Model -> ( Model, Cmd Msg.Msg )
update msg model =
    let
        session =
            model.session
    in
        case msg of
            GetTime time ->
                let
                    session_ =
                        { session | time = Just time }

                    model_ =
                        { model | session = session_ }
                in
                    model_ ! []
