module View exposing (view)

import Html exposing (..)
import Model exposing (Model)
import Msg exposing (..)
import Model.PageState exposing (Page(..))
import View.About
import View.Home
import Router exposing (reverseHref)


viewNav : Page -> Html Msg
viewNav page =
    nav []
        [ a [ reverseHref Home ] [ text "Home" ]
        , a [ reverseHref About ] [ text "About" ]
        ]


viewFooter : Html Msg
viewFooter =
    footer []
        [ p [] [ text "This is the footer" ]
        ]


view : Model -> Html Msg
view model =
    div []
        [ viewNav model.pageState.page
        , case model.pageState.page of
            Home ->
                View.Home.view model

            About ->
                View.About.view model
        , viewFooter
        ]
