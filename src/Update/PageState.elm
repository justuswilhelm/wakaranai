module Update.PageState exposing (update)

import Model.PageState exposing (Page(..))
import Msg
import Msg.PageState exposing (..)
import Model exposing (Model)
import Cmds.Session


loadContent : Page -> Cmd Msg.Msg
loadContent page =
    case page of
        HomeP ->
            Cmds.Session.getTime

        _ ->
            Cmd.none


update : Msg -> Model -> ( Model, Cmd Msg.Msg )
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
                    model_ ! [ loadContent page ]
