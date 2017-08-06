module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)


--

import Model exposing (Model)
import Model.PageState exposing (Page(..))
import Msg
import Msg.PageState
import Router exposing (reverseHref)
import View.About
import View.Home


viewNav : Page -> Html Msg.PageState.Msg
viewNav page =
    nav
        [ class "navbar" ]
        [ div [ class "container" ]
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
        ]


view : Model -> Html Msg.Msg
view model =
    div []
        [ section [ class "section" ]
            [ div [ class "container" ] <|
                case model.pageState.page of
                    HomeP ->
                        View.Home.view model

                    AboutP ->
                        View.About.view model
            ]
        , model.pageState.page
            |> viewNav
            |> Html.map Msg.PageState
        ]
