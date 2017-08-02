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
        [ div [ class "container" ]
            [ a
                [ reverseHref Home
                , class "navbar-item"
                ]
                [ text "Home" ]
            , a
                [ reverseHref About
                , class "navbar-item"
                ]
                [ text "About" ]
            ]
        ]


view : Model -> Html Msg
view model =
    div []
        [ section [ class "section" ]
            [ div [ class "container" ] <|
                case model.pageState.page of
                    Home ->
                        View.Home.view model

                    About ->
                        View.About.view model
            ]
        , viewNav model.pageState.page
        ]
