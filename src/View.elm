module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (Model)
import Msg exposing (..)
import Model.PageState exposing (Page(..))
import View.About
import View.Home
import Router exposing (reverseHref)


viewNav : Page -> Html Msg
viewNav page =
    nav
        [ class "navbar" ]
        [ a
            [ reverseHref HomeP
            , class "navbar-item"
            ]
            [ text "Home" ]
        , a
            [ reverseHref AboutP
            , class "navbar-item"
            ]
            [ text "About" ]
        ]


viewFooter : Html Msg
viewFooter =
    footer
        [ class "footer" ]
        [ p [] [ text "This is the footer" ]
        ]


view : Model -> Html Msg
view model =
    div []
        [ viewNav model.pageState.page
        , section [ class "section" ] <|
            case model.pageState.page of
                HomeP ->
                    View.Home.view model

                AboutP ->
                    View.About.view model
        , viewFooter
        ]
