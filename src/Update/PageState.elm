module Update.PageState exposing (update)

import Model exposing (Model)
import Msg
import Msg exposing (..)
import Msg.PageState exposing (..)


update : Msg.PageState.Msg -> Model -> ( Model, Cmd Msg.Msg )
update msg model =
    let
        pageState =
            model.pageState
    in
        case msg of
            Navigate page ->
                let
                    model_ =
                        { model | pageState = { pageState | page = page } }
                in
                    model_ ! []
