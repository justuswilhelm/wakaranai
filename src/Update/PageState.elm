module Update.PageState exposing (update)

import Msg exposing (..)
import Model exposing (Model)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        pageState =
            model.pageState
    in
        case msg of
            Navigate page ->
                { model | pageState = { pageState | page = page } } ! []
