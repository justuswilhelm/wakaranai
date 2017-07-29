module View exposing (view)

import Html exposing (..)
import Model exposing (Model)
import Msg exposing (..)
import View.Home
import Model.PageState exposing (Page(..))


viewNav : Html Msg
viewNav =
    nav []
        [ p [] [ text "This is the nav bar" ]
        ]


viewFooter : Html Msg
viewFooter =
    footer []
        [ p [] [ text "This is the footer" ]
        ]


view : Model -> Html Msg
view model =
    div []
        [ viewNav
        , case model.pageState.page of
            Home ->
                View.Home.view model
        , viewFooter
        ]
