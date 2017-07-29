module View exposing (view)

import Html exposing (..)
import Model exposing (Model)
import Msg exposing (..)
import View.Home
import Model.PageState exposing (Page(..))


view : Model -> Html Msg
view model =
    case model.pageState.page of
        Home ->
            View.Home.view model
