module Update.Session exposing (update)

import Model exposing (Model)
import Msg
import Msg.Session exposing (..)


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
